// swift-tools-version:5.9
// 배포 repo(SauceSDK_iOS-Binary) 루트에 복사해서 사용한다.
// 같은 repo 에 커밋된 SauceSDK.xcframework 를 직접 참조한다 (checksum 불필요).
import PackageDescription

let package = Package(
    name: "SauceSDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "SauceSDK", targets: ["SauceSDK"]),
    ],
    targets: [
        .binaryTarget(name: "SauceSDK", path: "SauceSDK.xcframework"),
    ]
)
