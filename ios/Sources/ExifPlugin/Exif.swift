import Foundation
import ImageIO
import MobileCoreServices
import CoreLocation

public enum ImageProcessingError: Error {
    case invalidURL
    case failedToLoadImage
    case failedToCreateDestinationImage
    case failedToSaveImage
    case noGPSData
}

@objc public class Exif: NSObject {

    func setCoordinates(_ pathToImage: String, _ latitude: Double, _ longitude: Double) throws {

        // Convert the file path to a URL
        guard let fileURL = URL(string: pathToImage) else {
            throw ImageProcessingError.invalidURL
        }

        // Create an image source from the URL
        guard let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil) else {
            throw ImageProcessingError.failedToLoadImage
        }

        // Get the image metadata
        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any] else {
            throw ImageProcessingError.failedToLoadImage
        }

        // print("Original metadata: \(imageProperties)")

        // Create a mutable copy of the metadata
        var metadata = imageProperties

        // Modify the GPS metadata
        var gpsData = metadata[kCGImagePropertyGPSDictionary as String] as? [String: Any] ?? [:]
        gpsData[kCGImagePropertyGPSLatitude as String] = abs(latitude)
        gpsData[kCGImagePropertyGPSLatitudeRef as String] = (latitude >= 0.0) ? "N" : "S"
        gpsData[kCGImagePropertyGPSLongitude as String] = abs(longitude)
        gpsData[kCGImagePropertyGPSLongitudeRef as String] = (longitude >= 0.0) ? "E" : "W"
        metadata[kCGImagePropertyGPSDictionary as String] = gpsData

        // print("Modified metadata: \(metadata)")

        // Create a destination to write the new image data
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, kUTTypeJPEG, 1, nil) else {
            throw ImageProcessingError.failedToCreateDestinationImage
        }

        // Add the image and the updated metadata to the destination
        CGImageDestinationAddImageFromSource(destination, imageSource, 0, metadata as CFDictionary)

        // Finalize the destination to write the data
        if !CGImageDestinationFinalize(destination) {
            throw ImageProcessingError.failedToSaveImage
        }

        // print("Successfully saved image with updated metadata")
    }
    
    func getCoordinates(filePath: String) throws -> CLLocationCoordinate2D {

        // Convert the file path to a URL
        guard let fileURL = URL(string: filePath) else {
            throw ImageProcessingError.invalidURL
        }

        // Create an image source from the URL
        guard let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil) else {
            throw ImageProcessingError.failedToLoadImage
        }

        // Get the image metadata
        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any] else {
            throw ImageProcessingError.failedToLoadImage
        }

        // Extract the GPS metadata
        guard let gpsData = imageProperties[kCGImagePropertyGPSDictionary as String] as? [String: Any],
              let latitude = gpsData[kCGImagePropertyGPSLatitude as String] as? Double,
              let latitudeRef = gpsData[kCGImagePropertyGPSLatitudeRef as String] as? String,
              let longitude = gpsData[kCGImagePropertyGPSLongitude as String] as? Double,
              let longitudeRef = gpsData[kCGImagePropertyGPSLongitudeRef as String] as? String else {
            throw ImageProcessingError.noGPSData
        }

        // Calculate the coordinates
        let finalLatitude = (latitudeRef == "N") ? latitude : -latitude
        let finalLongitude = (longitudeRef == "E") ? longitude : -longitude

        return CLLocationCoordinate2D(latitude: finalLatitude, longitude: finalLongitude)
    }

}
