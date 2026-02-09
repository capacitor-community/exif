import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ExifPlugin)
public class ExifPlugin: CAPPlugin, CAPBridgedPlugin {

    public let identifier = "ExifPlugin"
    public let jsName = "Exif"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "setCoordinates", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getCoordinates", returnType: CAPPluginReturnPromise)
    ]

    // Message constants
    static let invalidUrlError = "Invalid URL"
    static let failedToLoadImageError = "Failed to load image"
    static let failedToCreateDestinationImageError = "Failed to create destination image"
    static let failedToSaveImageError = "Failed to save image"

    private let implementation = Exif()

    @objc func setCoordinates(_ call: CAPPluginCall) {

        guard let pathToImage = call.options["pathToImage"] as? String else {
            call.reject("Must provide an pathToImage")
            return
        }
        guard let latitude = call.options["lat"] as? Double else {
            call.reject("Must provide an lat")
            return
        }
        guard let longitude = call.options["lng"] as? Double else {
            call.reject("Must provide an lng")
            return
        }

        do {
            try implementation.setCoordinates(pathToImage, latitude, longitude)
            call.resolve()
        } catch ImageProcessingError.invalidURL {
            call.reject(ExifPlugin.invalidUrlError)
        } catch ImageProcessingError.failedToLoadImage {
            call.reject(ExifPlugin.failedToLoadImageError)
        } catch ImageProcessingError.failedToCreateDestinationImage {
            call.reject(ExifPlugin.failedToCreateDestinationImageError)
        } catch ImageProcessingError.failedToSaveImage {
            call.reject(ExifPlugin.failedToSaveImageError)
        } catch {
            call.reject(error.localizedDescription, nil, error)
        }

    }

    @objc func getCoordinates(_ call: CAPPluginCall) {

        guard let pathToImage = call.options["pathToImage"] as? String else {
            call.reject("Must provide an pathToImage")
            return
        }

        do {
            let coordinates = try implementation.getCoordinates(filePath: pathToImage)
            call.resolve([
                "lat": coordinates.latitude,
                "lng": coordinates.longitude
            ])
        } catch ImageProcessingError.invalidURL {
            call.reject(ExifPlugin.invalidUrlError)
        } catch ImageProcessingError.failedToLoadImage {
            call.reject(ExifPlugin.failedToLoadImageError)
        } catch ImageProcessingError.noGPSData {
            call.resolve()
        } catch {
            call.reject(error.localizedDescription, nil, error)
        }

    }

}
