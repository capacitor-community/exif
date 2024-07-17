package com.ryltsov.alex.plugins.exif;

import android.util.Log;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Exif")
public class ExifPlugin extends Plugin {

    private static final String TAG = "ExifPlugin";

    private final Exif implementation = new Exif();

    @PluginMethod(returnType = PluginMethod.RETURN_PROMISE)
    public void setCoordinates(final PluginCall call) {
        
        if (!call.getData().has("pathToImage")) {
            call.reject("Must provide an pathToImage");
            return;
        }
        if (!call.getData().has("lat")) {
            call.reject("Must provide an lat");
            return;
        }
        if (!call.getData().has("lng")) {
            call.reject("Must provide an lng");
            return;
        }

        String pathToImage = call.getString("pathToImage");
        double latitude = call.getDouble("lat");
        double longitude = call.getDouble("lng");

        try {
            implementation.setCoordinates(pathToImage, latitude, longitude);
        } catch (Exception e) {
            Log.e(TAG, "Error setting GPS data to image", e);
            call.reject(e.getLocalizedMessage(), null, e);
            return;
        }

        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_PROMISE)
    public void getCoordinates(final PluginCall call) {
        
        if (!call.getData().has("pathToImage")) {
            call.reject("Must provide an pathToImage");
            return;
        }

        String pathToImage = call.getString("pathToImage");

        double[] latLong = null;
        try {
            latLong = implementation.getCoordinates(pathToImage);
        } catch (Exception e) {
            Log.e(TAG, "Error getting GPS data from image", e);
            call.reject(e.getLocalizedMessage(), null, e);
            return;
        }
        if ((latLong != null ? latLong.length : 0) == 2) {
            JSObject ret = new JSObject();
            double latitude = latLong[0];
            double longitude = latLong[1];
            ret.put("lat", latitude);
            ret.put("lng", longitude);
            call.resolve(ret);
            return;
        }
        call.resolve();
    }

}
