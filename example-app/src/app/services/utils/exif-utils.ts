import { Injectable } from '@angular/core';

// NATIVE
import { GetCoordinatesOptions, SetCoordinatesOptions, Exif } from '@capacitor-community/exif';

// // MODELS
// import { AppError } from '@models/base';

// PROVIDERS
// import { CapacitorPlugins } from '@services/capacitor-plugins/capacitor-plugins';
// import { CoordinatesFormatter } from '@services/formatters/coordinates-formatter';
// import { DeviceUtils } from '@services/utils/device-utils';
// import { LocationUtils } from '@services/utils/location-utils';
// import { Logger } from '@services/logger/logger';
// import { Exif } from '@capacitor-community/exif';

@Injectable({
    providedIn: 'root',
})
export class EXIFUtils {

    // public exifPlugin: ExifPlugin;

    constructor(
        // private coordinatesFormatter: CoordinatesFormatter,
        // private deviceUtils: DeviceUtils,
        // private locationUtils: LocationUtils,
        // private logger: Logger
    ) {
        // this.exifPlugin = this.capacitorPlugins.getExifPlugin();
    }

    /**
     * Method to set arbitrary coordinates to the image EXIF
     * 
     * @param pathToImage path to the image
     * @param lat latitude
     * @param lng longitude
     * 
     * @returns promise which resolves to void
     */
    public async setCoordinates(
        pathToImage: string,
        lat: number,
        lng: number
    ): Promise<void> {
        if (!lat || !lng) {
            // NOTE: nothing to set to the EXIF if latitude and longitude are not provided so just return
            return;
        }
        try {
            const options: SetCoordinatesOptions = {
                pathToImage,
                lat,
                lng
            };
            await Exif.setCoordinates(options);
        } catch (error) {
            console.error('[EXIFUtils] setCoordinates - failed to set EXIF coordinates', error);
        }
    }

    /**
     * Method to get the coordinates from the image EXIF
     * 
     * @param pathToImage path to the image
     * 
     * @returns promise which resolves to the coordinates (latitude and longitude) or undefined 
     */
    public async getCoordinates(
        pathToImage: string
    ): Promise<{
        lat: number;
        lng: number;
    } | undefined> {
        try {
            const options: GetCoordinatesOptions = { pathToImage };
            const coordinates: {
                lat: number;
                lng: number;
            } | undefined = await Exif.getCoordinates(options);
            return coordinates;
        } catch (error) {
            console.error('[EXIFUtils] getCoordinates - failed to get EXIF coordinates', error);
        }
        return;
    }

}
