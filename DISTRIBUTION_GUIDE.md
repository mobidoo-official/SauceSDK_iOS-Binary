# SauceSDK 배포 가이드

## 📦 XCFramework 배포 방식

SauceSDK는 **Static Linking** 방식으로 빌드된 XCFramework를 제공합니다.

### 🔥 주요 특징

- ✅ **코드 보안**: 소스코드가 바이너리로 컴파일되어 노출되지 않음
- ✅ **의존성 격리**: Kingfisher, SnapKit 등 외부 라이브러리가 내장되어 버전 충돌 없음
- ✅ **간편한 설치**: 별도 의존성 설치 불필요
- ✅ **다중 플랫폼**: iOS Device, iOS Simulator 지원

---

## 🚀 배포 프로세스

### 1. XCFramework 빌드

```bash
# XCFramework 빌드
./build_xcframework.sh

# 또는 전체 배포 프로세스 실행
./release.sh 1.0.0
```

### 2. 배포 파일 구조

```
SauceSDK/
├── SauceSDK.xcframework/          # 메인 프레임워크
├── SauceSDK.podspec              # CocoaPods 설정
├── Package.swift                 # SPM 설정
├── build_xcframework.sh          # 빌드 스크립트
└── release.sh                    # 배포 스크립트
```

---

## 📋 사용법

### CocoaPods

#### Podfile
```ruby
platform :ios, '13.0'

target 'YourApp' do
  use_frameworks!
  
  pod 'SauceSDK', '~> 1.0.0'
end
```

#### 설치
```bash
pod install
```

### Swift Package Manager

#### Package.swift
```swift
dependencies: [
    .package(url: "https://github.com/mobidoo-official/SauceSDK_iOS-Binary.git", from: "1.0.0")
]
```

#### Xcode에서 추가
1. **File** → **Add Package Dependencies**
2. URL 입력: `https://github.com/mobidoo-official/SauceSDK_iOS-Binary.git`
3. **Add Package** 클릭

---

## 💻 코드 사용법

### 1. 초기화 (AppDelegate)

```swift
import SauceSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // SauceSDK 초기화 (공통)
        SauceClient.initInstance(partnerID: "your_partner_id", apiHost: .stage)
        
        return true
    }
}
```

### 2. 라이브 플레이어

```swift
import SauceSDK

class LiveViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 라이브 플레이어 클라이언트 생성
        let liveClient = SauceLivePlayerClient.getInstance(
            broadcastID: "broadcast_123",
            viewController: self
        )
        
        // 콜백 설정
        liveClient.onShare = { shareInfo in
            print("공유: \(shareInfo)")
        }
        
        liveClient.onProduct = { productInfo in
            print("상품: \(productInfo)")
        }
        
        // 플레이어 시작
        liveClient.startPlayer()
    }
}
```

### 3. 클립 플레이어

```swift
import SauceSDK

class ClipViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 클립 플레이어 클라이언트 생성
        let clipClient = SauceClipPlayerClient.getInstance(viewController: self)
        
        // 콜백 설정
        clipClient.onShare = { shareInfo in
            print("공유: \(shareInfo)")
        }
        
        clipClient.onProduct = { productInfo in
            print("상품: \(productInfo)")
        }
        
        // 리워드 토큰 설정 (옵션)
        clipClient.setRewardToken("reward_token_123")
        
        // 플레이어 시작
        clipClient.startPlayer()
    }
}
```

### 4. 쇼룸

```swift
import SauceSDK

class ShowRoomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 쇼룸 클라이언트 생성
        let showRoomClient = ShowRoomClient.getInstance(
            showRoomID: "showroom_123",
            viewController: self
        )
        
        // 플레이어 실행 콜백 설정
        showRoomClient.onLivePlayer = { [weak self] broadcastID, token in
            self?.openLivePlayer(broadcastID: broadcastID, token: token)
        }
        
        showRoomClient.onClipPlayer = { [weak self] clipRewardToken in
            self?.openClipPlayer(clipRewardToken: clipRewardToken)
        }
        
        // 쇼룸 뷰 생성
        let showRoomView = showRoomClient
        view.addSubview(showRoomView)
        
        // Auto Layout 설정
        showRoomView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 쇼룸 시작
        showRoomView.startPlayer()
    }
}
```

---

## ⚠️ 주의사항

### 1. 의존성 충돌 방지

SauceSDK는 다음 라이브러리들을 내장하고 있습니다:
- Kingfisher (이미지 로딩)
- SnapKit (Auto Layout)
- Alamofire (네트워킹)
- SocketIO (실시간 통신)
- Lottie (애니메이션)
- SkeletonView (로딩 UI)

**앱에서 동일한 라이브러리를 사용하는 경우**: 버전 충돌 없이 각각 독립적으로 동작합니다.

### 2. 최소 요구사항

- **iOS 13.0+**
- **Swift 5.0+**
- **Xcode 12.0+**

### 3. 앱 크기 증가

XCFramework 크기: **약 48MB**
- 외부 의존성들이 포함되어 있어 크기가 클 수 있습니다
- 앱 스토어 업로드 시 App Thinning으로 실제 다운로드 크기는 줄어듭니다

---

## 🔧 개발자 도구

### 빌드 스크립트

```bash
# XCFramework 빌드만
./build_xcframework.sh

# 전체 배포 프로세스 (버전 지정)
./release.sh 1.2.0

# 기본 버전으로 배포
./release.sh
```

### 검증

```bash
# Podspec 검증
pod spec lint SauceSDK.podspec --allow-warnings

# XCFramework 아키텍처 확인
lipo -info SauceSDK.xcframework/*/SauceSDK.framework/SauceSDK
```

---

## 📞 지원

문제가 발생하거나 질문이 있으시면 연락해 주세요:

- **이메일**: contact@mobidoo.com
- **GitHub Issues**: [프로젝트 이슈 페이지]

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 