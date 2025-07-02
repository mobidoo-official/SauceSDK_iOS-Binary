Pod::Spec.new do |spec|
  spec.name                 = "SauceSDK"
  spec.version              = "0.0.2"
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
    :tag => "v#{spec.version}" 
  }
  
  # XCFramework 설정 (Static Linking - 의존성 격리)
  spec.vendored_frameworks  = "SauceSDK.xcframework"
  
  # 시스템 프레임워크 (필수만)
  spec.frameworks           = "UIKit", "Foundation", "AVFoundation"
  
  # Swift 버전
  spec.swift_version        = "5.0"
  
  # Static Framework 설정 (의존성 충돌 방지를 위해 필수)
  spec.requires_arc         = true
  spec.static_framework     = true
  
  # 의존성 없음 (Static Linking으로 모든 의존성 포함됨)
  # Kingfisher, SnapKit, Alamofire 등이 XCFramework에 내장됨
  
  # User Script Sandboxing 호환 설정
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
    'ENABLE_BITCODE' => 'NO',
    'ENABLE_USER_SCRIPT_SANDBOXING' => 'YES',
    'DEFINES_MODULE' => 'YES'
  }
  
  spec.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
    'ENABLE_BITCODE' => 'NO'
  }
  
  # Sandboxing 문제 해결을 위한 추가 설정
  spec.script_phases = []  # 추가 스크립트 단계 제거
end 