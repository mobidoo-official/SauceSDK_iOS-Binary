Pod::Spec.new do |spec|
  spec.name                 = "SauceSDK"
    spec.version              = "0.0.1"
  spec.summary              = "SauceSDK - Live Commerce SDK for iOS"
  spec.description          = <<-DESC
                              SauceSDK는 라이브 커머스 기능을 제공하는 iOS SDK입니다.
                              라이브 스트리밍, 클립 플레이어, 쇼룸 기능을 포함합니다.
                              DESC
  
  spec.homepage             = "https://github.com/mobidoo-official/SauceSDK_iOS-Binary"
  spec.license              = { :type => "MIT", :file => "LICENSE" }
  spec.author               = { "Mobidoo" => "contact@mobidoo.com" }
  
  # 플랫폼 지원
  spec.ios.deployment_target = "13.0"
  
  # 소스
  spec.source               = { 
    :git => "https://github.com/mobidoo-official/SauceSDK_iOS-Binary.git", 
    :tag => "#{spec.version}" 
  }
  
  # XCFramework 설정 (Static Linking)
  spec.vendored_frameworks  = "SauceSDK.xcframework"
  
  # 프레임워크 설정
  spec.frameworks           = "UIKit", "Foundation", "AVFoundation", "WebKit"
  spec.libraries            = "c++", "z"
  
  # Swift 버전
  spec.swift_version        = "5.0"
  
  # 빌드 설정
  spec.requires_arc         = true
  spec.static_framework     = true
  
  # 의존성 없음 (Static Linking으로 모든 의존성 포함됨)
  # spec.dependency 'Kingfisher' - 제거됨
  # spec.dependency 'SnapKit' - 제거됨
  
  # 추가 설정
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
    'ENABLE_BITCODE' => 'NO'
  }
  
  spec.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
    'ENABLE_BITCODE' => 'NO'
  }
end 