# SauceSDK 배포 가이드

## 🚀 **코드 수정 후 재배포 완전 가이드**

개발용 저장소에서 코드 수정 후 CocoaPods와 SPM으로 배포하는 전체 과정을 **Step-by-Step**으로 설명합니다.

---

## 📋 **사전 준비**

### **필요한 계정 및 도구**
- [x] **GitHub 계정** (저장소 접근 권한)
- [x] **CocoaPods 계정** (`mobidooinfo@gmail.com`)
- [x] **개발 환경**: Xcode 12.0+, macOS 10.15+
- [x] **터미널 도구**: Git, CocoaPods CLI

### **저장소 구조**
```
📁 개발용 저장소: SauceSDK/
├── 소스코드 및 빌드 스크립트
├── BINARY_BUILD_GUIDE.md (빌드 과정)
└── XCFramework 생성

📁 배포용 저장소: SauceSDK_iOS-Binary/
├── SauceSDK.xcframework (바이너리)
├── SauceSDK.podspec (CocoaPods)
├── Package.swift (SPM)
├── README.md (사용법)
└── DEPLOY_GUIDE.md (이 문서)
```

---

## 🔧 **STEP 1: 개발용 저장소에서 XCFramework 빌드**

### **1-1. 코드 수정 확인**
```bash
cd /path/to/SauceSDK  # 개발용 저장소

# 변경사항 확인
git status

# 커밋 (필요한 경우)
git add .
git commit -m "기능 수정 완료"
git push origin main
```

### **1-2. XCFramework 빌드**
```bash
# 빌드 스크립트 실행
chmod +x build_xcframework.sh
./build_xcframework.sh
```

**빌드 과정** (약 3-5분 소요):
1. ✅ 기존 빌드 파일 정리
2. ✅ iOS Device 아카이브 생성 (arm64)
3. ✅ iOS Simulator 아카이브 생성 (arm64, x86_64)
4. ✅ XCFramework 생성 및 의존성 포함

### **1-3. ZIP 파일 생성 및 체크섬 계산**
```bash
# Build 디렉토리로 이동
cd Build

# ZIP 파일 생성
zip -r SauceSDK.xcframework.zip SauceSDK.xcframework

# 체크섬 계산 (중요!)
shasum -a 256 SauceSDK.xcframework.zip
```

**📝 중요**: 체크섬 값을 메모해두세요! (SPM 배포 시 필요)

예시:
```
9fd942dc293e9245e7f45b49061da455ceecfe6c60b96006fb0be4f659ecf583  SauceSDK.xcframework.zip
```

---

## 📦 **STEP 2: 배포용 저장소로 파일 복사**

### **2-1. 배포용 저장소로 이동**
```bash
cd /path/to/SauceSDK_iOS-Binary  # 배포용 저장소

# 최신 상태로 업데이트
git pull origin main
```

### **2-2. XCFramework 복사**
```bash
# 기존 XCFramework 제거
rm -rf SauceSDK.xcframework

# 새로운 XCFramework 복사
cp -R /path/to/SauceSDK/Build/SauceSDK.xcframework ./

# ZIP 파일도 복사 (GitHub Release용)
cp /path/to/SauceSDK/Build/SauceSDK.xcframework.zip ./
```

### **2-3. 파일 크기 확인**
```bash
# XCFramework 크기 확인
du -sh SauceSDK.xcframework
# 예상 결과: ~13-15MB

# ZIP 파일 크기 확인
ls -lh SauceSDK.xcframework.zip
# 예상 결과: ~13-15MB
```

---

## 🏷️ **STEP 3: 버전 업데이트**

### **3-1. 새 버전 결정**
기존 배포 버전을 확인하고 새 버전을 결정하세요:

```bash
# 현재 태그 확인
git tag --sort=-version:refname | head -5

# 예시 결과:
# v0.0.2  ← 현재 최신
# v0.0.1
```

**버전 규칙**:
- **패치 버전** (0.0.X): 버그 수정, 작은 개선
- **마이너 버전** (0.X.0): 새 기능 추가
- **메이저 버전** (X.0.0): 큰 변경사항, 호환성 깨짐

### **3-2. podspec 파일 업데이트**
```bash
# SauceSDK.podspec 편집
nano SauceSDK.podspec
```

버전 변경:
```ruby
Pod::Spec.new do |spec|
  spec.name         = "SauceSDK"
  spec.version      = "0.0.3"  # ← 새 버전으로 변경
  # ... 나머지 설정 유지
end
```

### **3-3. Package.swift 업데이트**
```bash
# Package.swift 편집
nano Package.swift
```

체크섬과 버전 변경:
```swift
let package = Package(
    name: "SauceSDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "SauceSDK", targets: ["SauceSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "SauceSDK",
            url: "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/download/v0.0.3/SauceSDK.xcframework.zip",  // ← 새 버전
            checksum: "9fd942dc293e9245e7f45b49061da455ceecfe6c60b96006fb0be4f659ecf583"  // ← 새 체크섬
        )
    ]
)
```

---

## 📤 **STEP 4: GitHub Release 생성**

### **4-1. Git 커밋 및 푸시**
```bash
# 변경사항 커밋
git add .
git commit -m "Release v0.0.3: [변경사항 간단 설명]"
git push origin main
```

### **4-2. GitHub Release 생성**

**방법 1: GitHub 웹사이트**
1. https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases
2. **"Create a new release"** 클릭
3. **Tag version**: `v0.0.3` (새 태그 생성)
4. **Release title**: `SauceSDK v0.0.3`
5. **Description**: 변경사항 설명
6. **Attach files**: `SauceSDK.xcframework.zip` 업로드
7. **Publish release** 클릭

**방법 2: GitHub CLI** (설치된 경우)
```bash
# Release 생성 및 파일 업로드
gh release create v0.0.3 SauceSDK.xcframework.zip \
  --title "SauceSDK v0.0.3" \
  --notes "변경사항 설명"
```

### **4-3. Release 확인**
```bash
# 릴리즈 URL 확인
echo "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/tag/v0.0.3"

# ZIP 다운로드 URL 확인
echo "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/download/v0.0.3/SauceSDK.xcframework.zip"
```

---

## 🍫 **STEP 5: CocoaPods 배포**

### **5-1. podspec 검증**
```bash
# 로컬 검증
pod spec lint SauceSDK.podspec --verbose

# 성공 시 출력:
# -> SauceSDK (0.0.3)
# 
# SauceSDK passed validation.
```

**⚠️ 검증 실패 시**:
- GitHub Release가 완료되었는지 확인
- ZIP 파일이 정상 업로드되었는지 확인
- podspec의 URL과 버전이 정확한지 확인

### **5-2. CocoaPods 배포**
```bash
# CocoaPods 배포
pod trunk push SauceSDK.podspec --verbose

# 성공 시 출력:
# Updating spec repo `cocoapods`
# Validating podspec
# Updating the `SauceSDK` pod
# [!] You can now use the new version in your pod install
```

### **5-3. 배포 확인**
```bash
# 배포 상태 확인
pod search SauceSDK

# 또는 웹에서 확인
echo "https://cocoapods.org/pods/SauceSDK"
```

---

## 📦 **STEP 6: Swift Package Manager 배포**

### **6-1. Package.swift 최종 확인**
```bash
# Package.swift 내용 확인
cat Package.swift
```

다음 내용이 정확한지 확인:
- ✅ **URL**: GitHub Release 다운로드 링크
- ✅ **버전**: 새로 생성한 태그 버전
- ✅ **체크섬**: STEP 1에서 계산한 값

### **6-2. Git 태그 생성 및 푸시**
```bash
# 태그 생성 (이미 GitHub Release로 생성되었으면 skip)
git tag v0.0.3
git push origin v0.0.3
```

### **6-3. SPM 배포 확인**

**로컬 테스트**:
1. 임시 Xcode 프로젝트 생성
2. **File** → **Add Package Dependencies**
3. URL 입력: `https://github.com/mobidoo-official/SauceSDK_iOS-Binary.git`
4. 버전 선택: `0.0.3`
5. **Add Package** 클릭하여 정상 동작 확인

---

## ✅ **STEP 7: 배포 완료 확인**

### **7-1. 최종 체크리스트**

- [ ] **XCFramework 빌드 완료** (개발용 저장소)
- [ ] **파일 복사 완료** (배포용 저장소)
- [ ] **버전 업데이트** (podspec, Package.swift)
- [ ] **GitHub Release 생성** (ZIP 파일 포함)
- [ ] **CocoaPods 배포 성공**
- [ ] **SPM 배포 확인**

### **7-2. 사용자 테스트**

**CocoaPods 설치 테스트**:
```ruby
# Podfile
pod 'SauceSDK', '~> 0.0.3'
```

**SPM 설치 테스트**:
```
https://github.com/mobidoo-official/SauceSDK_iOS-Binary.git
```

### **7-3. 문서 업데이트**

README.md의 설치 예시를 새 버전으로 업데이트:
```bash
# README.md 편집
nano README.md
```

---

## 🚨 **문제 해결**

### **자주 발생하는 문제들**

#### **1. CocoaPods 배포 실패**
```bash
# 에러: "Unable to find the binary"
# 해결: GitHub Release가 완료되었는지 확인

# 에러: "Checksum mismatch"  
# 해결: 체크섬을 다시 계산하여 podspec 업데이트
```

#### **2. SPM 설치 실패**
```bash
# 에러: "Invalid checksum"
# 해결: Package.swift의 체크섬 값 확인

# 에러: "Repository not found"
# 해결: GitHub Release 및 태그 생성 확인
```

#### **3. XCFramework 빌드 실패**
```bash
# Clean Build 후 재시도
rm -rf Build/
rm -rf ~/Library/Developer/Xcode/DerivedData/Sauce-*
./build_xcframework.sh
```

### **롤백 방법**

문제 발생 시 이전 버전으로 롤백:
```bash
# 1. Git 되돌리기
git reset --hard HEAD~1

# 2. 태그 삭제
git tag -d v0.0.3
git push origin :refs/tags/v0.0.3

# 3. GitHub Release 삭제 (웹에서)

# 4. CocoaPods 이전 버전 사용 안내
```

---

## 📈 **배포 히스토리 관리**

### **CHANGELOG.md 업데이트**
```bash
# CHANGELOG.md 생성/업데이트
nano CHANGELOG.md
```

예시 형식:
```markdown
# Changelog

## [0.0.3] - 2024-01-XX
### Added
- 새로운 기능 추가

### Fixed  
- 버그 수정 내용

### Changed
- 변경사항
```

### **릴리즈 노트 작성**
각 GitHub Release에 다음 내용 포함:
- 🆕 **새로운 기능**
- 🐛 **버그 수정**
- ⚡ **성능 개선**
- 💥 **Breaking Changes** (있는 경우)

---

## 📞 **지원 및 문의**

배포 과정에서 문제가 발생하면:

1. **이 가이드의 문제 해결 섹션** 확인
2. **빌드 로그 및 에러 메시지** 분석
3. **GitHub Issues** 작성 또는 개발팀 문의
4. **이메일**: mobidooinfo@gmail.com

---

## 🔄 **다음 배포를 위한 준비**

배포 완료 후:
1. **개발용 저장소**에 배포 완료 커밋
2. **버전 계획** 수립 (다음 마이너/메이저 업데이트)
3. **사용자 피드백** 수집 및 반영 계획

---

**Made with ❤️ by Mobidoo Development Team**

---

## 📚 **부록: 명령어 요약**

### **개발용 저장소**
```bash
# XCFramework 빌드
./build_xcframework.sh

# ZIP 생성 및 체크섬
cd Build
zip -r SauceSDK.xcframework.zip SauceSDK.xcframework
shasum -a 256 SauceSDK.xcframework.zip
```

### **배포용 저장소**
```bash
# 파일 복사
cp -R /path/to/SauceSDK/Build/SauceSDK.xcframework ./

# 버전 업데이트 후 배포
git add .
git commit -m "Release v0.0.X"
git push origin main
git tag v0.0.X
git push origin v0.0.X

# CocoaPods 배포
pod spec lint SauceSDK.podspec
pod trunk push SauceSDK.podspec
``` 