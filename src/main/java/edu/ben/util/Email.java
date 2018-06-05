package edu.ben.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class Email {

    public static String studentVerification(String benEmail) {

        String code = "";
        for (int i = 0; i < 6; i++) {
            code += (int)(Math.random() * 10);
        }

        sendEmail("Your verification code is: " + code,
                "Student Status Verification", benEmail);

        return code;
    }

    public static void sendAdminInvite (String email) {

        sendEmail("You have been invited to register as a U-ListIt administrator. \nClick the link below to register. \n" +
                        "http://www.u-listit/register",
                "U-ListIt Invite", email);

    }

    public static String resetPassword(String email) {

        String code = "";
        for (int i = 0; i < 6; i++) {
            code += (int)(Math.random() * 10);
        }

        sendEmail("Enter the following code to verify identity.\nCode: " + code, "Password Reset", email);

        return code;

    }
    
    public static String unlockAccount(String email) {

        String code = "";
        for (int i = 0; i < 6; i++) {
            code += (int)(Math.random() * 10);
        }

        sendEmail("Enter the following code to unlock your account.\nCode: " + code, "Account Unlock", email);

        return code;

    }

    public static void sendEmail(String mes, String subject, String email) {

        final String username = "ulistithelp@gmail.com";
        final String password = "u-listit";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(mes);

            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
