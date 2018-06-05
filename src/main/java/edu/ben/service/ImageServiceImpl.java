package edu.ben.service;

import edu.ben.dao.ImageDAO;
import edu.ben.model.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class ImageServiceImpl implements ImageService {

    ImageDAO imageDAO;

    @Autowired
    public void setImageDAO(ImageDAO imageDAO) {
        this.imageDAO = imageDAO;
    }

    @Override
    public int save(Image image) {
        return imageDAO.save(image);
    }

    @Override
    public void saveOrUpdate(Image image) {
        imageDAO.saveOrUpdate(image);
    }

    @Override
    public List<Image> getImagesByListingId(int listingId) {
        return imageDAO.getImagesByListingId(listingId);
    }

    @Override
    public List<Image> getImagesByUserId(int userId) {
        return imageDAO.getImagesByUserId(userId);
    }

    @Override
    public void removeAllMainImages(int userId) {
        imageDAO.removeAllMainImages(userId);
    }

    @Override
    public void changeMain(int imageId, int main) {
        imageDAO.changeMain(imageId,main);
    }

}
