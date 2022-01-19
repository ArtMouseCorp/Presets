import Foundation
import FirebaseRemoteConfig
import SwiftyJSON

enum RCValueKey: String {
    case organicSubscriptionPage = "org_sub_page"
    case subscriptionPlansPage = "sub_plans_page"
    case saleSubscriptionsPage = "sale_sub_page"
    case currentPaywall
    
    internal enum OrganicSubscriptionPage: String {
        case titleLabel
        case subtitleLabel
        case closeDelay
        case priceLabel
        case priceLabelFontSize
        case priceLabelOpacity
        case buttonLabel
        case buttonFontSize
        case showTerms
        case subscriptionId
    }
    
    internal enum SubscriptionPlansPage: String {
        case titleLabel
        case subtitleLabel
        case trialPeriodLabel
        case closeDelay
        case priceLabelFontSize
        case priceLabelOpacity
        case buttonLabel
        case buttonFontSize
        case showTerms
        case firstSubscriptionId
        case secondSubscriptionId
        case thirdSubscriptionId
    }
    
    internal enum SaleSubscriptionPage: String {
        case smallSaleOfferView
        case titleLabel
        case saleLabel
        case limitedWarningLabel
        case priceLabel
        case subscriptionButtonLabel
        case timeLeftLabel
        case saleDurationSeconds
        case subscriptionId
        
        internal enum SmallSaleOfferView: String {
            case titleLabel
            case descriptionLabel
            case buttonLabel
        }
    }
}

class RCValues {
    
    static let sharedInstance = RCValues()
    
    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            RCValueKey.organicSubscriptionPage.rawValue: OrganicSubscriptionPage.default,
            RCValueKey.subscriptionPlansPage.rawValue: SubscriptionPlansPage.default,
            RCValueKey.saleSubscriptionsPage.rawValue: SaleSubscriptionPage.default,
            RCValueKey.currentPaywall.rawValue: 1
            
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        // WARNING: Don't actually do this in production!
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() {
        // 1
        activateDebugMode()
        
        // 2
        RemoteConfig.remoteConfig().fetch { _, error in
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                // In a real app, you would probably want to call the loading
                // done callback anyway, and just proceed with the default values.
                // I won't do that here, so we can call attention
                // to the fact that Remote Config isn't loading.
                return
            }
            
            // 3
            RemoteConfig.remoteConfig().activate { _, _ in
                print("Retrieved values from the cloud!")
            }
        }
    }
    
    func organicSubscriptionPage() -> OrganicSubscriptionPage {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return OrganicSubscriptionPage.default
        }
        
        let key = RCValueKey.organicSubscriptionPage.rawValue
        
        let jsonValue = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = jsonValue else {
            return OrganicSubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let titleLabel: String              = json[RCValueKey.OrganicSubscriptionPage.titleLabel.rawValue].stringValue
        let subtitleLabel: String           = json[RCValueKey.OrganicSubscriptionPage.subtitleLabel.rawValue].stringValue
        let closeDelay: Double              = Double(json[RCValueKey.OrganicSubscriptionPage.closeDelay.rawValue].floatValue)
        let priceLabel: String              = json[RCValueKey.OrganicSubscriptionPage.priceLabel.rawValue].stringValue
        let priceLabelFontSize: CGFloat     = CGFloat(json[RCValueKey.OrganicSubscriptionPage.priceLabelFontSize.rawValue].floatValue)
        let priceLabelOpacity: CGFloat      = CGFloat(json[RCValueKey.OrganicSubscriptionPage.priceLabelOpacity.rawValue].floatValue)
        let buttonLabel: String             = json[RCValueKey.OrganicSubscriptionPage.buttonLabel.rawValue].stringValue
        let buttonFontSize: CGFloat         = CGFloat(json[RCValueKey.OrganicSubscriptionPage.buttonFontSize.rawValue].floatValue)
        let showTerms: Bool                 = json[RCValueKey.OrganicSubscriptionPage.showTerms.rawValue].boolValue
        let subscriptionId: String          = json[RCValueKey.OrganicSubscriptionPage.subscriptionId.rawValue].stringValue
        
        let orgSubPage = OrganicSubscriptionPage(
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            closeDelay: closeDelay,
            priceLabel: priceLabel,
            priceLabelFontSize: priceLabelFontSize,
            priceLabelOpacity: priceLabelOpacity,
            buttonLabel: buttonLabel,
            buttonFontSize: buttonFontSize,
            showTerms: showTerms,
            subscriptionId: subscriptionId
        )
        
        return orgSubPage
    }
    
    func subscriptionPlansPage() -> SubscriptionPlansPage {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return SubscriptionPlansPage.default
        }
        
        let key = RCValueKey.subscriptionPlansPage.rawValue
        
        let jsonValue = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = jsonValue else {
            return SubscriptionPlansPage.default
        }
        
        let json = JSON(value)
        
        let titleLabel: String              = json[RCValueKey.SubscriptionPlansPage.titleLabel.rawValue].stringValue
        let subtitleLabel: String           = json[RCValueKey.SubscriptionPlansPage.subtitleLabel.rawValue].stringValue
        let trialPeriodLabel: String        = json[RCValueKey.SubscriptionPlansPage.trialPeriodLabel.rawValue].stringValue
        let closeDelay: Double              = Double(json[RCValueKey.SubscriptionPlansPage.closeDelay.rawValue].floatValue)
        let priceLabelFontSize: CGFloat     = CGFloat(json[RCValueKey.SubscriptionPlansPage.priceLabelFontSize.rawValue].floatValue)
        let priceLabelOpacity: CGFloat      = CGFloat(json[RCValueKey.SubscriptionPlansPage.priceLabelOpacity.rawValue].floatValue)
        let buttonLabel: String             = json[RCValueKey.SubscriptionPlansPage.buttonLabel.rawValue].stringValue
        let buttonFontSize: CGFloat         = CGFloat(json[RCValueKey.SubscriptionPlansPage.buttonFontSize.rawValue].floatValue)
        let showTerms: Bool                 = json[RCValueKey.SubscriptionPlansPage.showTerms.rawValue].boolValue
        let firstSubscriptionId: String     = json[RCValueKey.SubscriptionPlansPage.firstSubscriptionId.rawValue].stringValue
        let secondSubscriptionId: String    = json[RCValueKey.SubscriptionPlansPage.secondSubscriptionId.rawValue].stringValue
        let thirdSubscriptionId: String     = json[RCValueKey.SubscriptionPlansPage.thirdSubscriptionId.rawValue].stringValue
        
        let subPlansPage = SubscriptionPlansPage(
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            trialPeriodLabel: trialPeriodLabel,
            closeDelay: closeDelay,
            priceLabelFontSize: priceLabelFontSize,
            priceLabelOpacity: priceLabelOpacity,
            buttonLabel: buttonLabel,
            buttonFontSize: buttonFontSize,
            showTerms: showTerms,
            firstSubscriptionId: firstSubscriptionId,
            secondSubscriptionId: secondSubscriptionId,
            thirdSubscriptionId: thirdSubscriptionId
        )
        
        return subPlansPage
        
    }
    
    func saleSubscriptionPage() -> SaleSubscriptionPage {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return SaleSubscriptionPage.default
        }
        
        print("Language: \(lang)")
        
        let key = RCValueKey.saleSubscriptionsPage.rawValue
        
        let jsonValue = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = jsonValue else {
            return SaleSubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let smallSafeOfferViewJsonObject = json[RCValueKey.SaleSubscriptionPage.smallSaleOfferView.rawValue].object
        
        let smallSafeOfferViewJson = JSON(smallSafeOfferViewJsonObject)
        
        let smallSafeOfferView = SaleSubscriptionPage.SmallSaleOfferView(
            titleLabel: smallSafeOfferViewJson[RCValueKey.SaleSubscriptionPage.SmallSaleOfferView.titleLabel.rawValue].stringValue,
            descriptionLabel: smallSafeOfferViewJson[RCValueKey.SaleSubscriptionPage.SmallSaleOfferView.descriptionLabel.rawValue].stringValue,
            buttonLabel: smallSafeOfferViewJson[RCValueKey.SaleSubscriptionPage.SmallSaleOfferView.buttonLabel.rawValue].stringValue
        )
        
        let titleLabel: String              = json[RCValueKey.SaleSubscriptionPage.titleLabel.rawValue].stringValue
        let saleLabel: String               = json[RCValueKey.SaleSubscriptionPage.saleLabel.rawValue].stringValue
        let limitedWarningLabel: String     = json[RCValueKey.SaleSubscriptionPage.limitedWarningLabel.rawValue].stringValue
        let priceLabel: String              = json[RCValueKey.SaleSubscriptionPage.priceLabel.rawValue].stringValue
        let subscriptionButtonLabel: String = json[RCValueKey.SaleSubscriptionPage.subscriptionButtonLabel.rawValue].stringValue
        let timeLeftLabel: String           = json[RCValueKey.SaleSubscriptionPage.timeLeftLabel.rawValue].stringValue
        let saleDurationSeconds: Int        = json[RCValueKey.SaleSubscriptionPage.saleDurationSeconds.rawValue].intValue
        let subscriptionId: String          = json[RCValueKey.SaleSubscriptionPage.subscriptionId.rawValue].stringValue
        
        let saleSubPage = SaleSubscriptionPage(
            smallSaleOfferView: smallSafeOfferView,
            titleLabel: titleLabel,
            saleLabel: saleLabel,
            limitedWarningLabel: limitedWarningLabel,
            priceLabel: priceLabel,
            subscriptionButtonLabel: subscriptionButtonLabel,
            timeLeftLabel: timeLeftLabel,
            saleDurationSeconds: saleDurationSeconds,
            subscriptionId: subscriptionId
        )
        
        return saleSubPage
        
    }
    
    func currentPaywall() -> BaseViewController {
        
        let key = RCValueKey.currentPaywall.rawValue
        let currentPaywallNumber = RemoteConfig.remoteConfig()[key].numberValue.intValue
        
        switch currentPaywallNumber {
        
        case 1: return .load(from: .subscriptionFirst)
        case 2: return .load(from: .subscriptionSecond)
        case 3: return .load(from: .subscriptionThird)
        default: return .load(from: .subscriptionFirst)
            
        }
        
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
