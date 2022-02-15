platform :ios, '13.0'

target 'Presets' do

  use_frameworks!

pod 'Amplitude'
pod 'OneSignalXCFramework'
pod 'AppsFlyerFramework'

pod 'Firebase/Analytics'
pod 'Firebase/RemoteConfig'
pod 'Firebase/Database'


pod 'Google-Mobile-Ads-SDK'

pod 'SwiftyJSON'
pod 'Purchases'

pod 'SkarbSDK'
pod 'YandexMobileMetrica/Dynamic'
pod 'Alamofire'

pod 'FBSDKCoreKit'
pod 'FBAEMKit'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
