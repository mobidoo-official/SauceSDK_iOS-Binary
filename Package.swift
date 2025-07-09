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
            path: "SauceSDK.xcframework"  // 로컬 경로 사용 (같은 레포 내)
        )
    ]
) 