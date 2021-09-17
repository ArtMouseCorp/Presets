import Foundation
import FirebaseRemoteConfig
import SwiftyJSON

enum RCValueKey: String {
    case organicSubscriptionPage = "org_sub_page"
    case subscriptionPlansPage = "sub_plans_page"
    
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
            RCValueKey.subscriptionPlansPage.rawValue: SubscriptionPlansPage.default
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
        
        let value = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = value else {
            return OrganicSubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let titleLabel: String              = json[RCValueKey.OrganicSubscriptionPage.titleLabel.rawValue].stringValue
        let subtitleLabel: String           = json[RCValueKey.OrganicSubscriptionPage.subtitleLabel.rawValue].stringValue
        let closeDelay: CGFloat             = CGFloat(json[RCValueKey.OrganicSubscriptionPage.closeDelay.rawValue].floatValue)
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
        
        let value = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = value else {
            return SubscriptionPlansPage.default
        }
        
        let json = JSON(value)
        
        let titleLabel: String              = json[RCValueKey.SubscriptionPlansPage.titleLabel.rawValue].stringValue
        let subtitleLabel: String           = json[RCValueKey.SubscriptionPlansPage.subtitleLabel.rawValue].stringValue
        let closeDelay: CGFloat             = CGFloat(json[RCValueKey.SubscriptionPlansPage.closeDelay.rawValue].floatValue)
        let priceLabelFontSize: CGFloat     = CGFloat(json[RCValueKey.SubscriptionPlansPage.priceLabelFontSize.rawValue].floatValue)
        let priceLabelOpacity: CGFloat      = CGFloat(json[RCValueKey.SubscriptionPlansPage.priceLabelOpacity.rawValue].floatValue)
        let buttonLabel: String             = json[RCValueKey.SubscriptionPlansPage.buttonLabel.rawValue].stringValue
        let buttonFontSize: CGFloat         = CGFloat(json[RCValueKey.SubscriptionPlansPage.buttonFontSize.rawValue].floatValue)
        let showTerms: Bool                 = json[RCValueKey.SubscriptionPlansPage.showTerms.rawValue].boolValue
        let firstSubscriptionId: String          = json[RCValueKey.SubscriptionPlansPage.firstSubscriptionId.rawValue].stringValue
        let secondSubscriptionId: String          = json[RCValueKey.SubscriptionPlansPage.secondSubscriptionId.rawValue].stringValue
        let thirdSubscriptionId: String          = json[RCValueKey.SubscriptionPlansPage.thirdSubscriptionId.rawValue].stringValue
        
        let subPlansPage = SubscriptionPlansPage(
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
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