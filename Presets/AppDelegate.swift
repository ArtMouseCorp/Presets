import UIKit
import Amplitude
import OneSignal
import AppsFlyerLib
import Firebase
import GoogleMobileAds
import SwiftyStoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        State.newAppLaunch()
        
        registerTransactionObserver()
//        connectAmplitude()
        connectOneSignal(with: launchOptions)
        connectAppsFlyer()
        connectFirebase()
        connectGoogleMobileAds()
        
        _ = RCValues.sharedInstance
        
        return true
    }
    
    // SceneDelegate support - start AppsFlyer SDK
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
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
    
    private func registerTransactionObserver() {
    SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break // do nothing
                }
            }
        }
    }
    
    private func connectAmplitude() {
        Amplitude.instance().trackingSessionEvents = true
        Amplitude.instance().initializeApiKey(Keys.Amplitude.apiKey)
    }
    
    private func connectOneSignal(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
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
    }
    
    
}

// MARK: - AppsFlyerLibDelegate

extension AppDelegate: AppsFlyerLibDelegate {
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        return
    }
    
    func onConversionDataFail(_ error: Error) {
        return
    }
    
}
