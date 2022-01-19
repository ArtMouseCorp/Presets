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
    public static var currentPaywall: BaseViewController = .load(from: .subscriptionFirst)
    
    // MARK: - Functions
    
    public static func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
    }
    
    public static func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
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
