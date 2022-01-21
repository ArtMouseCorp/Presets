platform :ios, '13.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'OneSignalNotificationServiceExtension' do

  use_frameworks!

  pod 'OneSignalXCFramework'

end

target 'Presets' do

  use_frameworks!

pod 'Amplitude'
pod 'OneSignalXCFramework'
pod 'AppsFlyerFramework'

pod 'Firebase/Analytics'
pod 'Firebase/RemoteConfig'
pod 'Firebase/Storage'
pod 'Google-Mobile-Ads-SDK'

pod 'SwiftyJSON'
pod 'Purchases'

pod 'SkarbSDK'
pod 'YandexMobileMetrica/Dynamic'
pod 'Alamofire'

pod 'FBSDKCoreKit'
pod 'FBAEMKit'

end
