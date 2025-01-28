import { Component } from '@angular/core';
import { NgIf } from '@angular/common';
import {
  IonHeader, IonButton, IonToolbar, IonTitle, IonContent, IonButtons, IonLabel
} from '@ionic/angular/standalone';

// NATIVE
import { Camera, CameraSource, CameraResultType } from '@capacitor/camera';

// PROVIDERS
import { EXIFUtils } from '../services/utils/exif-utils';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  imports: [
    IonButton, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonLabel, NgIf
  ]
})
export class HomePage {

  public originalImageWebPath: string | undefined | null;
  public originalCoordinates: {
    lat: number;
    lng: number;
  } | undefined;
  public newCoordinates: {
    lat: number;
    lng: number;
  } | undefined;

  constructor(
    private exifUtils: EXIFUtils
  ) { }

  public async testExif(): Promise<void> {

    const photo = await Camera.getPhoto({
      quality: 100,
      allowEditing: false,
      resultType: CameraResultType.Uri,
      saveToGallery: true,
      correctOrientation: true,
      source: CameraSource.Prompt
    });

    if (photo.path && photo.webPath) {
      this.originalImageWebPath = photo.webPath;
      await new Promise(resolve => setTimeout(resolve, 250));

      const originalImageElement = document.getElementById('originalImage') as HTMLImageElement;
      // NOTE: Can be set to the src of an image now
      const timestamp = new Date().getTime(); // NOTE: Generate a unique timestamp
      originalImageElement.src = `${this.originalImageWebPath}?t=${timestamp}`; // NOTE: Append the timestamp as a query parameter

      try {
        const originalCoordinates = await this.exifUtils.getCoordinates(photo.path);
        this.originalCoordinates = originalCoordinates;
      } catch (error) {
        console.error('Failed to get original coordinates: ' + JSON.stringify(error));
      }
      try {
        await this.exifUtils.setCoordinates(photo.path, 55, 66);
      } catch (error) {
        console.error('Failed to set new coordinates: ' + JSON.stringify(error));
      }
      try {
        const newCoordinates = await this.exifUtils.getCoordinates(photo.path);
        this.newCoordinates = newCoordinates;
      } catch (error) {
        console.error('Failed to get new coordinates: ' + JSON.stringify(error));
      }
    }

  };

}
