import Foundation

struct State {
    
    // MARK: - Variables
    
    private static var appLaunch: Int = 0
    
    public static var isSubscribed: Bool = false
    public static var currentProductId: String = ""
    
    public static var language: Language = .en
    public static var favouritePresets: [Int] = []
    public static var secondsTillTheEndOfOffer = 10800
    
    public static var selectedPreset: Preset = .defaultPreset
    
    public static var subscriptionConfig: OrganicSubscriptionPage = .default
    public static var subscriptionPlansConfig: SubscriptionPlansPage = .default
    
    public static var saleSubscriptionPage: SaleSubscriptionPage = .default
    
    public static var firstSubscriptionPage: FirstSubscriptionPage = .default
    public static var secondSubscriptionPage: SecondSubscriptionPage = .default
    public static var thirdSubscriptionPage: ThirdSubscriptionPage = .default
    
    public static var currentPaywall: BaseViewController = .load(from: .subscriptionFirst)
    public static var paywallNumber: Int = 1
    
    // MARK: - Functions
    
    public static func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
    }
    
    public static func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
    }
    
    public static func setCurrentPaywall() {
        userDefaults.set(self.paywallNumber, forKey: UDKeys.paywallNumber)
    }
    
    public static func getCurrentPaywall() -> BaseViewController {
        self.paywallNumber = userDefaults.value(forKey: UDKeys.paywallNumber) as? Int ?? 0
        switch self.paywallNumber {
        case 0:
            return SubscriptionViewController.load(from: .subscription)
        case 1:
            return SubscriptionFirstViewController.load(from: .subscriptionFirst)
        case 2:
            return SubscriptionSecondViewController.load(from: .subscriptionSecond)
        case 3:
            return SubscriptionThirdViewController.load(from: .subscriptionThird)
        default:
            return SubscriptionViewController.load(from: .subscription)
        }
    }
    
    public static func isFirstLaunch() -> Bool {
        return self.appLaunch == 1
    }
    
    // MARK: - Sale Offer
    
    public static func startSaleOffer() {
        if userDefaults.bool(forKey: UDKeys.isStartSaleOfferDateSet) {
            return
        }
        
        userDefaults.set(Date(), forKey: UDKeys.saleOfferStartDate)
        userDefaults.set(true, forKey: UDKeys.isStartSaleOfferDateSet)
    }
    
    public static func getStartSaleOfferDate() -> Date {
        return userDefaults.object(forKey: UDKeys.saleOfferStartDate) as! Date
    }
    
}
