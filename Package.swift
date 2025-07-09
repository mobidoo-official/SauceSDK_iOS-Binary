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
            url: "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/download/v0.0.20/SauceSDK.xcframework.zip",
            checksum: "placeholder_checksum_will_be_updated_by_ci"
        )
    ]
)
