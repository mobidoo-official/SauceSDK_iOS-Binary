// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SauceSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SauceSDK",
            targets: ["SauceSDK"]),
    ],
    dependencies: [
        // XCFramework 배포에서는 의존성 없음 (Static Linking)
    ],
    targets: [
        .binaryTarget(
            name: "SauceSDK",
            url: "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/download/v0.0.2/SauceSDK.xcframework.zip",
            checksum: "9fd942dc293e9245e7f45b49061da455ceecfe6c60b96006fb0be4f659ecf583"
        )
    ]
) 