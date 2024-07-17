package com.ryltsov.alex.plugins.exif;

import android.net.Uri;
import android.util.Log;

import androidx.exifinterface.media.ExifInterface;

import java.io.IOException;

public class Exif {

    public void setCoordinates(String pathToImage, double latitude, double longitude) throws IOException {

        Uri fileUri = Uri.parse(pathToImage);
        // Convert the file:// URI to a file path string
        String filePath = fileUri.getPath();
        // Create an ExifInterface instance using the file path
        ExifInterface exif = new ExifInterface(filePath);
        exif.setLatLong(latitude, longitude);
        // Save the changes
        exif.saveAttributes();

    }


    public double[] getCoordinates(String pathToImage) throws IOException {

        Uri fileUri = Uri.parse(pathToImage);
        // Convert the file:// URI to a file path string
        String filePath = fileUri.getPath();
        // Create an ExifInterface instance using the file path
        ExifInterface exif = new ExifInterface(filePath);

        return exif.getLatLong();

    }

}
