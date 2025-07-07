// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SauceSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SauceSDK",
            targets: ["SauceSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "SauceSDK",
            path: "SauceSDK.xcframework"
        )
    ]
)
