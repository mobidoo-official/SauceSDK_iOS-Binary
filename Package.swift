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
            url: "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/download/v0.0.11/SauceSDK.xcframework.zip",
            checksum: "ddf043808993aa39fe4d22d29c947d7634c6c9ebacf51b27cc92ff1da9be3f4a"
        )
    ]
)
