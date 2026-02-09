<p align="center"><br><img src="https://user-images.githubusercontent.com/236501/85893648-1c92e880-b7a8-11ea-926d-95355b8175c7.png" width="128" height="128" /></p>
<h3 align="center">Capacitor Exif Plugin</h3>
<p align="center"><strong><code>@capacitor-community/exif</code></strong></p>
<p align="center">
  Capacitor community plugin for interacting with image exif metadata
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2026?style=flat-square" />
  <a href="https://www.npmjs.com/package/@capacitor-community/exif"><img src="https://img.shields.io/npm/l/@capacitor-community/exif?style=flat-square" /></a>
  <br>
  <a href="https://www.npmjs.com/package/@capacitor-community/exif"><img src="https://img.shields.io/npm/dw/@capacitor-community/exif?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@capacitor-community/exif"><img src="https://img.shields.io/npm/v/@capacitor-community/exif?style=flat-square" /></a>
  <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
  <a href="#contributors-"><img src="https://img.shields.io/badge/all%20contributors-1-orange?style=flat-square" /></a>
  <!-- ALL-CONTRIBUTORS-BADGE:END -->
</p>

# Table of Contents

- [Maintainers](#maintainers)
- [About](#about)
- [Plugin versions](#plugin-versions)
- [Supported Platforms](#supported-platforms)
- [Installation](#installation)
- [Configuration](#configuration)
- [API](#api)
- [Troubleshooting](#troubleshooting)

## Maintainers

| Maintainer | GitHub                          | Active |
| ---------- | ------------------------------- | ------ |
| ryaa       | [ryaa](https://github.com/ryaa) | yes    |

## About

This plugins allows reading and setting coordinates to image files.
This plugin has been primarity implemented to enhance other plugins which require coordinates to be added to images, for example https://github.com/capacitor-community/camera-preview/issues/164.

**Features:**

- support reading coordinates from image files
- support setting coordinates to image files
- supports Android and iOS platforms

**NOTE**: The plugin version 8.0.0 is compatible with Capacitor 8

## Plugin versions

| Capacitor version | Plugin version |
| ----------------- | -------------- |
| 8.x               | 8.x            |
| 7.x               | 7.x            |
| 6.x               | 6.x            |

## Supported Platforms

- iOS
- Android

## Installation

```bash
npm install @capacitor-community/exif
npx cap sync
```

## Configuration

### Android

This plugin will use the following project variables (defined in your app's variables.gradle file):

```
androidxExifInterfaceVersion: version of androidx.exifinterface:exifinterface (default: 1.3.6)
```

## API

<docgen-index>

* [`setCoordinates(...)`](#setcoordinates)
* [`getCoordinates(...)`](#getcoordinates)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### setCoordinates(...)

```typescript
setCoordinates(options: SetCoordinatesOptions) => Promise<void>
```

Set the coordinates to the image EXIF metadata.

| Param         | Type                                                                    |
| ------------- | ----------------------------------------------------------------------- |
| **`options`** | <code><a href="#setcoordinatesoptions">SetCoordinatesOptions</a></code> |

**Since:** 6.0.0

--------------------


### getCoordinates(...)

```typescript
getCoordinates(options: GetCoordinatesOptions) => Promise<{ lat: number; lng: number; } | undefined>
```

Get the coordinates from the image EXIF metadata.

| Param         | Type                                                                    |
| ------------- | ----------------------------------------------------------------------- |
| **`options`** | <code><a href="#getcoordinatesoptions">GetCoordinatesOptions</a></code> |

**Returns:** <code>Promise&lt;{ lat: number; lng: number; }&gt;</code>

**Since:** 6.0.0

--------------------


### Interfaces


#### SetCoordinatesOptions

| Prop              | Type                | Description                                                        | Since |
| ----------------- | ------------------- | ------------------------------------------------------------------ | ----- |
| **`pathToImage`** | <code>string</code> | The path to the image to set the coordinates to the EXIF metadata. | 6.0.0 |
| **`lat`**         | <code>number</code> | The latitude of the image coordinates.                             | 6.0.0 |
| **`lng`**         | <code>number</code> | The longitude of the image coordinates.                            | 6.0.0 |


#### GetCoordinatesOptions

| Prop              | Type                | Description                                                      | Since |
| ----------------- | ------------------- | ---------------------------------------------------------------- | ----- |
| **`pathToImage`** | <code>string</code> | The path to the image to get the coordinates from EXIF metadata. | 6.0.0 |

</docgen-api>

## Usage

Please also see **example-app** for a complete example.

### Set coordinates to image file

```
import { Exif } from '@capacitor-community/exif';

const options: SetCoordinatesOptions = {
    pathToImage,
    lat,
    lng
};
await this.exifPlugin.setCoordinates(options);
```

### Read coordinates from image file

```
import { Exif } from '@capacitor-community/exif';

const options: GetCoordinatesOptions = { pathToImage };
const coordinates: {
    lat: number;
    lng: number;
} | undefined = await this.exifPlugin.getCoordinates(options);
```
