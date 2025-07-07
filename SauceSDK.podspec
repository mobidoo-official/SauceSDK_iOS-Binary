Pod::Spec.new do |spec|
  spec.name             = 'SauceSDK'
  spec.version          = '0.0.11'
  spec.summary          = 'SauceSDK for iOS - Video streaming and player SDK'
  spec.description      = <<-DESC
    SauceSDK provides comprehensive video streaming and player functionality for iOS applications.
    Features include live streaming, clip playback, showroom functionality, and more.
  DESC
  
  spec.homepage         = 'https://github.com/mobidoo-official/SauceSDK_iOS-Binary'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'Mobidoo' => 'contact@mobidoo.com' }
  spec.source           = { 
    :http => "https://github.com/mobidoo-official/SauceSDK_iOS-Binary/releases/download/v0.0.11/SauceSDK.xcframework.zip"
  }
  
  spec.platform         = :ios, '13.0'
  spec.ios.deployment_target = '13.0'
  
  spec.vendored_frameworks = 'SauceSDK.xcframework'
  spec.swift_version = '5.0'
  spec.requires_arc = true
end
