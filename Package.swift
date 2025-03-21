// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorCommunityExif",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorCommunityExif",
            targets: ["ExifPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "ExifPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/ExifPlugin"),
        .testTarget(
            name: "ExifPluginTests",
            dependencies: ["ExifPlugin"],
            path: "ios/Tests/ExifPluginTests")
    ]
)
