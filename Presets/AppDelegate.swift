import UIKit
import Amplitude
import OneSignal
import AppsFlyerLib
import Firebase
import GoogleMobileAds
import Purchases
import AppTrackingTransparency
import SkarbSDK
import YandexMobileMetrica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        State.newAppLaunch()
        
        connectAmplitude()
        connectRevenueCat()
        connectOneSignal(with: launchOptions)
        connectAppsFlyer()
        connectFirebase()
        connectGoogleMobileAds()
        connectProdinfire()
        connectAppMetrika()
                
        _ = RCValues.sharedInstance
        _ = StorageManager.sharedInstance
        
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAppsFlyerConversionDataSuccess(_:)), name: .onAppsFlyerConversionDataSuccess, object: nil)
        
        return true
    }
    
    @objc private func onAppsFlyerConversionDataSuccess(_ notification: Notification) {
        guard State.isFirstLaunch() && !ProdinfireManager.sharedInstance.isInstallEventSent() else { return }
        ProdinfireManager.sharedInstance.sendInstallEvent()
    }
    
    // SceneDelegate support - start AppsFlyer SDK
    @objc private func sendLaunch() {
        AppsFlyerLib.shared().start()
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization() { status in }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        AppsFlyerLib.shared().start()
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Custom functions
    
    private func fetchData() {
        Preset.get()
        Preset.getFavorites()
        
        State.subscriptionConfig = RCValues.sharedInstance.organicSubscriptionPage()
        State.subscriptionPlansConfig = RCValues.sharedInstance.subscriptionPlansPage()
    }
    
    private func connectRevenueCat() {
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Keys.RevenueCat.apiKey)
        
    }
    
    private func connectAmplitude() {
        Amplitude.instance().trackingSessionEvents = true
        Amplitude.instance().initializeApiKey(Keys.Amplitude.apiKey)
    }
    
    private func connectOneSignal(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Remove this method to stop OneSignal Debugging
        //        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        // OneSignal initialization
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Keys.OneSignal.appId)
        
        // promptForPushNotifications will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
    private func connectAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = Keys.AppsFlyer.devKey
        AppsFlyerLib.shared().appleAppID = Keys.appleAppId
        
        /* Uncomment the following line to see AppsFlyer debug logs */
        // AppsFlyerLib.shared().isDebug = true
        // Must be called AFTER setting appsFlyerDevKey and appleAppID
        AppsFlyerLib.shared().delegate = self
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        
        // SceneDelegate support
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func connectFirebase() {
        FirebaseApp.configure()
    }
    
    private func connectGoogleMobileAds() {
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["1440558f13893d763cad8b1259572f8b"]
    }
    
    private func connectProdinfire() {
        SkarbSDK.initialize(clientId: Keys.Prodinfire.apiKey, isObservable: true)
        
        func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
            SkarbSDK.sendSource(broker: .appsflyer, features: conversionInfo)
        }
    }
    
    private func connectAppMetrika() {
        // Initializing the AppMetrica SDK.
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: Keys.AppMetrika.apiKey)
        configuration?.logs = true
        configuration?.revenueAutoTrackingEnabled = true
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    
}

// MARK: - AppsFlyerLibDelegate

extension AppDelegate: AppsFlyerLibDelegate {
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        ProdinfireManager.sharedInstance.setAppsFlyerConversation(to: conversionInfo)
        NotificationCenter.default.post(name: .onAppsFlyerConversionDataSuccess, object: nil, userInfo: conversionInfo)
        return
    }
    
    func onConversionDataFail(_ error: Error) {
        return
    }
    
}
