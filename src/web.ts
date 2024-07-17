import { WebPlugin } from '@capacitor/core';

import type { GetCoordinatesOptions, SetCoordinatesOptions, ExifPlugin } from './definitions';

export class ExifWeb extends WebPlugin implements ExifPlugin {

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  public async setCoordinates(_options: SetCoordinatesOptions): Promise<void> {
    throw new Error('setCoordinates is not supported on web');
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  public async getCoordinates(_options: GetCoordinatesOptions): Promise<{
      lat: number;
      lng: number;
    } | undefined> {
    throw new Error('getCoordinates is not supported on web');
  }

}
