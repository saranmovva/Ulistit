package edu.ben.service;

import edu.ben.model.Image;

import java.util.List;

public interface ImageService {

    public int save(Image image);

    public void saveOrUpdate(Image image);

    public List<Image> getImagesByListingId(int listingId);

    public List<Image> getImagesByUserId(int userId);

    public void removeAllMainImages(int userId);

    public void changeMain(int imageId, int main);
}
