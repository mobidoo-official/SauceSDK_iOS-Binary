# 배포 repo(SauceSDK_iOS-Binary) 루트에 복사해서 사용한다.
# 버전은 build_xcframework.sh 가 만든 프레임워크의 MARKETING_VERSION 과 같아야 한다.
Pod::Spec.new do |s|
  s.name             = 'SauceSDK'
  s.version          = '1.0.1'
  s.summary          = 'Sauce Live SDK for iOS'
  s.description      = 'Live commerce player SDK (LIVE/VOD, chat, coupon, reward) by Mobidoo.'
  s.homepage         = 'https://sauce.im'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Mobidoo' => 'mobidooinfo@gmail.com' }
  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'
  s.source           = { :git => 'https://github.com/mobidoo-official/SauceSDK_iOS-Binary.git', :tag => "v#{s.version}" }
  s.vendored_frameworks = 'SauceSDK.xcframework'
end
