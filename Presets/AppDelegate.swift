import UIKit
import Amplitude
import OneSignal
import AppsFlyerLib
import Firebase
import FirebaseDatabase
import GoogleMobileAds
import Purchases
import AppTrackingTransparency
import SkarbSDK
import YandexMobileMetrica
import FBSDKCoreKit
import FBAEMKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        State.newAppLaunch()
        
        connectAmplitude()
        connectRevenueCat()
        connectOneSignal(with: launchOptions)
        connectSkarbSDK()
        connectAppsFlyer()
        connectFirebase()
        connectGoogleMobileAds()
        connectAppMetrika()
        connectFacebook(for: application, with: launchOptions)
        
        _ = RCValues.sharedInstance
        
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAppsFlyerConversionDataSuccess(_:)), name: .onAppsFlyerConversionDataSuccess, object: nil)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        AEMReporter.configure(withNetworker: nil, appID: Keys.Facebook.appId, reporter: nil)
        AEMReporter.enable()
        AEMReporter.handle(url)
        
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    @objc private func onAppsFlyerConversionDataSuccess(_ notification: Notification) {
        guard State.isFirstLaunch() && !ProdinfireManager.sharedInstance.isInstallEventSent() else { return }
        ProdinfireManager.sharedInstance.sendInstallEvent()
    }
    
    // SceneDelegate support - start AppsFlyer SDK
    @objc private func sendLaunch() {
        AppsFlyerLib.shared().start()
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization() { status in }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().start()
        AppEvents.shared.activateApp()
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

        Preset.load()
        
//        Preset.getFavorites()
        
        State.subscriptionConfig = RCValues.sharedInstance.organicSubscriptionPage()
        State.subscriptionPlansConfig = RCValues.sharedInstance.subscriptionPlansPage()
        State.saleSubscriptionPage = RCValues.sharedInstance.saleSubscriptionPage()
        
        
        State.appVersionState = getAppVersionState()
        self.loadGlobalAppInstalls()
//        State.currentPaywall = RCValues.sharedInstance.currentPaywall()
    }
    
    private func loadGlobalAppInstalls() {
        
        guard State.isFirstLaunch() || State.appVersionState == .installed || State.appVersionState == .updated else { return }
        
        let appInstallsRef = Database.database().reference(withPath: "appInstalls")
        
        appInstallsRef.getData { error, snapshot in
            
            guard let globalAppInstall = snapshot.value as? Int, error == nil else {
                return
            }
            
            State.globalAppInstalls = globalAppInstall
            
            print("GLOBAL APP INSTALLS DEBUG | Fetched from Databse - \(globalAppInstall)")
            State.globalAppInstalls += 1
            
            appInstallsRef.setValue(State.globalAppInstalls)
            print("GLOBAL APP INSTALLS DEBUG | Sent to Databse - \(State.globalAppInstalls)")
            
        }
        
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
    
    private func connectSkarbSDK() {
        SkarbSDK.initialize(clientId: Keys.SkarbSDK.clientId, isObservable: true)
    }
    
    private func connectAppMetrika() {
        // Initializing the AppMetrica SDK.
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: Keys.AppMetrika.apiKey)
        configuration?.logs = true
        configuration?.revenueAutoTrackingEnabled = true
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    private func connectFacebook(for application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        Settings.shared.isAdvertiserTrackingEnabled = true
        Settings.shared.isAutoLogAppEventsEnabled = true
        Settings.shared.isAdvertiserIDCollectionEnabled = true
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
    
    
}

// MARK: - AppsFlyerLibDelegate

extension AppDelegate: AppsFlyerLibDelegate {
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        SkarbSDK.sendSource(broker: .appsflyer, features: conversionInfo)
        ProdinfireManager.sharedInstance.setAppsFlyerConversation(to: conversionInfo)
        NotificationCenter.default.post(name: .onAppsFlyerConversionDataSuccess, object: nil, userInfo: conversionInfo)
        return
    }
    
    func onConversionDataFail(_ error: Error) {
        return
    }
    
}
