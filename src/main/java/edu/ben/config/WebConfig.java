package edu.ben.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.io.*;
import java.nio.file.Files;
import java.util.Properties;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "edu")
public class WebConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
        registry.addResourceHandler("/directory/**").addResourceLocations("file:"+System.getProperty("user.home")+"/");
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/view/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver createCommonsMultipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding("utf-8");
        multipartResolver.setMaxUploadSize(20971520);    // 20MB
        multipartResolver.setMaxInMemorySize(1048576);    // 1MB
        return multipartResolver;
    }

    @PostConstruct
    public void imageCreate() throws IOException {
        Resource resource = new ClassPathResource("default.png");

        File defaultProfilePic = resource.getFile();
        System.out.println(defaultProfilePic.getAbsolutePath());
        byte[] data = Files.readAllBytes(defaultProfilePic.toPath());

        File dir = new File(System.getProperty("user.home") + File.separator + "ulistitUsers" + File.separator + "default");
        if (!dir.exists())
            dir.mkdirs();

        BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir + File.separator + defaultProfilePic.getName()));
        stream.write(data);
    }

}
