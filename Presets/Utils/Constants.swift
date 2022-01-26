import UIKit

let userDefaults = UserDefaults.standard

/// Declared whether app in the debug mode
public let DEBUG_MODE: Bool = false

enum UDKeys {
    static let appLaunchCount: String           = "appLaunchCount"
    static let isInstallEventSent: String       = "isInstallEventSent"
    static let favouritePresets: String         = "favouritePresets"
    static let saleOfferStartDate: String       = "saleOfferStartDate"
    static let isStartSaleOfferDateSet: String  = "isStartSaleOfferDateSet"
    static let currentAutoPaywall: String       = "currentAutoPaywall"
    static let appVersionOfLastRun: String      = "appVersionOfLastRun"
    static let appBuildOfLastRun: String        = "appBuildOfLastRun"
}

enum AmplitudeEvents {
    static let subscription: String             = "subscribe"
    static let firstTimeLaunch: String          = "launch_first_time"
    static let appLaunch: String                = "app_launch"
    static let watchAd: String                  = "ad_watch"
    static let onboarding: String               = "onboardingView"
    static let subscriptionButtonTap: String    = "subscription_tap"
    static let paywallClose: String             = "paywall_closed"
    static let ratingRequest: String            = "rating_request"
    static let subscribtion: String             = "subscribe"
    static let afterSubscriptionAd: String      = "ad_after_subscription_watch"
}

enum Keys {
    
    static let appleAppId: String               = "1581576260"
    
    // RevenueCat
    internal enum RevenueCat {
        
        static let debugApiKey: String          = "DETukuMSYjcwKcUwHHXpJnDvLlQHzKgV" // DEBUG
        static let releaseApiKey: String        = "AOyerJDdXCsOPBzfUledPlrOYXJvkhzX" // RELEASE
        
        static let apiKey: String               = DEBUG_MODE ? debugApiKey : releaseApiKey
        
        static let entitlementId: String        = "premium"
    }
    
    // Amplitude
    internal enum Amplitude {
        static let apiKey: String               = "57daf38d4f5529a9d79bfc46d341ad31"
    }
    
    // OneSignal
    internal enum OneSignal {
        static let appId: String                = "53aa320e-7a1c-4d28-ab0e-926440c12058"
    }
    
    // AdMob
    internal enum AdmMod {
        static let appId: String                = "ca-app-pub-9686541093041732~7231766062"
        
//        static let unitId: String               = "ca-app-pub-3940256099942544/4411468910" // DEBUG
        static let unitId: String               = "ca-app-pub-9686541093041732/2300386476" // RELEASE
    }
    
    // AppsFlyer
    internal enum AppsFlyer {
        static let devKey: String               = "5VCYcU4KGxS56mN9DjpnoN"
    }
    
    internal enum Prodinfire {
        static let apiKey: String               = "!G245JF7fh9s4tnFSwd83rJDKn"
        static let url: String                  = "https://artpoldev.com/api/presets/send.php"
    }
    
    internal enum AppMetrika {
        static let apiKey: String               = "44ff71f5-2dc7-4854-b0ce-a28d53d6331a"
    }
    
    internal enum SkarbSDK {
        static let clientId: String             = "danila"
    }
    
    internal enum Facebook {
        static let appId: String                = "281912480039810"
    }
}

public func hapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}
