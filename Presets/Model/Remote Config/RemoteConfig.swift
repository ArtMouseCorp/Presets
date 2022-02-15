import Foundation
import FirebaseRemoteConfig
import SwiftyJSON
import SkarbSDK

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
            
            RCValueKey.firstSubscriptionPage.rawValue: FirstSubscriptionPage.default,
            RCValueKey.secondSubscriptionPage.rawValue: SecondSubscriptionPage.default,
            RCValueKey.thirdSubscriptionPage.rawValue: ThirdSubscriptionPage.default,
            
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
                print("REMOTE CONFIG | Retrieved values from the cloud!")
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
    
    func firstSubscriptionPage() -> FirstSubscriptionPage {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return FirstSubscriptionPage.default
        }
        
        let key = RCValueKey.firstSubscriptionPage.rawValue
        
        let jsonValue = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = jsonValue else {
            return FirstSubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let titleLabel: String              = json[RCValueKey.FirstSubscriptionPage.titleLabel.rawValue].stringValue
        let trialOnLabel: String            = json[RCValueKey.FirstSubscriptionPage.trialOnLabel.rawValue].stringValue
        let trialOffLabel: String           = json[RCValueKey.FirstSubscriptionPage.trialOffLabel.rawValue].stringValue
        let isTrialOn: Bool                 = json[RCValueKey.FirstSubscriptionPage.isTrialOn.rawValue].boolValue
        let priceLabel: String              = json[RCValueKey.FirstSubscriptionPage.priceLabel.rawValue].stringValue
        let subscribeButtonLabel: String    = json[RCValueKey.FirstSubscriptionPage.subscribeButtonLabel.rawValue].stringValue
        let closeDelay: Int                 = json[RCValueKey.FirstSubscriptionPage.closeDelay.rawValue].intValue
        let showTerms: Bool                 = json[RCValueKey.FirstSubscriptionPage.showTerms.rawValue].boolValue
        let trialSubscriptionId: String     = json[RCValueKey.FirstSubscriptionPage.trialSubscriptionId.rawValue].stringValue
        let noTrialSubscriptionId: String   = json[RCValueKey.FirstSubscriptionPage.noTrialSubscriptionId.rawValue].stringValue
        
        let firstSubPage = FirstSubscriptionPage(
            titleLabel: titleLabel,
            trialOnLabel: trialOnLabel,
            trialOffLabel: trialOffLabel,
            isTrialOn: isTrialOn,
            priceLabel: priceLabel,
            subscribeButtonLabel: subscribeButtonLabel,
            closeDelay: closeDelay,
            showTerms: showTerms,
            trialSubscriptionId: trialSubscriptionId,
            noTrialSubscriptionId: noTrialSubscriptionId
        )
        
        return firstSubPage
    }
    
    func secondSubscriptionPage() -> SecondSubscriptionPage {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return SecondSubscriptionPage.default
        }
        
        let key = RCValueKey.secondSubscriptionPage.rawValue
        
        let jsonValue = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        guard let value = jsonValue else {
            return SecondSubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let firstProductJson = JSON(json[RCValueKey.SecondSubscriptionPage.firstProduct.rawValue].object)
        
        let firstProduct = SecondSubscriptionPage.Product(
            priceLabel: firstProductJson[RCValueKey.SecondSubscriptionPage.Product.priceLabel.rawValue].stringValue,
            totalPriceLabel: firstProductJson[RCValueKey.SecondSubscriptionPage.Product.totalPriceLabel.rawValue].string,
            subscriptionId: firstProductJson[RCValueKey.SecondSubscriptionPage.Product.subscriptionId.rawValue].stringValue
        )
        
        let secondProductJson = JSON(json[RCValueKey.SecondSubscriptionPage.secondProduct.rawValue].object)
        
        let secondProduct = SecondSubscriptionPage.Product(
            priceLabel: secondProductJson[RCValueKey.SecondSubscriptionPage.Product.priceLabel.rawValue].stringValue,
            totalPriceLabel: secondProductJson[RCValueKey.SecondSubscriptionPage.Product.totalPriceLabel.rawValue].string,
            subscriptionId: secondProductJson[RCValueKey.SecondSubscriptionPage.Product.subscriptionId.rawValue].stringValue
        )
        
        let titleLabel: String              = json[RCValueKey.SecondSubscriptionPage.titleLabel.rawValue].stringValue
        let subtitleLabel: String           = json[RCValueKey.SecondSubscriptionPage.subtitleLabel.rawValue].stringValue
        let subscribeButtonLabel: String    = json[RCValueKey.SecondSubscriptionPage.subscribeButtonLabel.rawValue].stringValue
        let economyLabel: String            = json[RCValueKey.SecondSubscriptionPage.economyLabel.rawValue].stringValue
        let closeDelay: Int                 = json[RCValueKey.SecondSubscriptionPage.closeDelay.rawValue].intValue
        let showTerms: Bool                 = json[RCValueKey.SecondSubscriptionPage.showTerms.rawValue].boolValue
        
        let secondSubPage = SecondSubscriptionPage(
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            subscribeButtonLabel: subscribeButtonLabel,
            economyLabel: economyLabel,
            closeDelay: closeDelay,
            showTerms: showTerms,
            firstProduct: firstProduct,
            secondProduct: secondProduct
        )
        
        return secondSubPage
        
    }
    
    func thirdSubscriptionPage() -> ThirdSubscriptionPage {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return ThirdSubscriptionPage.default
        }
        
        let key = RCValueKey.thirdSubscriptionPage.rawValue
        
        let jsonValue = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue
        
        print("Key \(key)_\(lang)")
        
        guard let value = jsonValue else {
            return ThirdSubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let titleLabel: String              = json[RCValueKey.ThirdSubscriptionPage.titleLabel.rawValue].stringValue
        let subtitleLabel: String           = json[RCValueKey.ThirdSubscriptionPage.subtitleLabel.rawValue].stringValue
        let priceLabel: String              = json[RCValueKey.ThirdSubscriptionPage.priceLabel.rawValue].stringValue
        let subscribeButtonLabel: String    = json[RCValueKey.ThirdSubscriptionPage.subscribeButtonLabel.rawValue].stringValue
        let features: [String]              = [
            json[RCValueKey.ThirdSubscriptionPage.features.rawValue].arrayValue[0].stringValue,
            json[RCValueKey.ThirdSubscriptionPage.features.rawValue].arrayValue[1].stringValue,
            json[RCValueKey.ThirdSubscriptionPage.features.rawValue].arrayValue[2].stringValue
        ]
        let closeDelay: Int                 = json[RCValueKey.ThirdSubscriptionPage.closeDelay.rawValue].intValue
        let showTerms: Bool                 = json[RCValueKey.ThirdSubscriptionPage.showTerms.rawValue].boolValue
        let subscriptionId: String          = json[RCValueKey.ThirdSubscriptionPage.subscriptionId.rawValue].stringValue
        
        let thirdSubPage = ThirdSubscriptionPage(
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            priceLabel: priceLabel,
            subscribeButtonLabel: subscribeButtonLabel,
            features: features,
            closeDelay: closeDelay,
            showTerms: showTerms,
            subscriptionId: subscriptionId
        )
        
        return thirdSubPage
        
    }
    
    func currentPaywall() -> BaseSubscriptionViewController {
        
        let key = RCValueKey.currentPaywall.rawValue
        
        let remotePaywallNumber = RemoteConfig.remoteConfig()[key].numberValue.intValue
        let automaticPaywallDistribution = self.automaticPaywallDistribution()
        
        
        // LOGIC:
        
        // if automaticPaywallDistribution && (isFirstLaunch || getAppVersionState() == .updated)
        // Automatic distributed paywall
        
        // if automaticPaywallDistribution && !isFirstLaunch
        // Default paywall
        
        // if !automaticPaywallDistribution
        // Always from firebase
        
        
        guard automaticPaywallDistribution else {
            
            // Show paywall specified in Firebase Remote Config
            
            print("PAYWALLS DEBUG | Fetched paywall number - \(remotePaywallNumber)")
            
            switch remotePaywallNumber {
                
            case 0:
                State.subscriptionConfig = self.organicSubscriptionPage()
                SkarbSDK.sendSource(broker: SKBroker.custom("organic_paywall"), features: [:])
                State.currentPaywall = "organic_paywall"
                return .load(from: .subscription)
            case 1:
                State.firstSubscriptionPage = self.firstSubscriptionPage()
                SkarbSDK.sendSource(broker: SKBroker.custom("first_paywall"), features: [:])
                State.currentPaywall = "first_paywall"
                return .load(from: .subscriptionFirst)
            case 2:
                State.secondSubscriptionPage = self.secondSubscriptionPage()
                SkarbSDK.sendSource(broker: SKBroker.custom("second_paywall"), features: [:])
                State.currentPaywall = "second_paywall"
                return .load(from: .subscriptionSecond)
            case 3:
                State.thirdSubscriptionPage = self.thirdSubscriptionPage()
                SkarbSDK.sendSource(broker: SKBroker.custom("third_paywall"), features: [:])
                State.currentPaywall = "third_paywall"
                return .load(from: .subscriptionThird)
            default:
                State.subscriptionConfig = self.organicSubscriptionPage()
                SkarbSDK.sendSource(broker: SKBroker.custom("organic_paywall"), features: [:])
                State.currentPaywall = "organic_paywall"
                return .load(from: .subscription)
            }
            
        }
        
        guard State.isFirstLaunch() || State.appVersionState == .updated || State.appVersionState == .installed else {

            // Show default paywall

            print("PAYWALLS DEBUG | Show default paywall")
            State.subscriptionConfig = self.organicSubscriptionPage()
            SkarbSDK.sendSource(broker: SKBroker.custom("organic_paywall"), features: [:])
            State.currentPaywall = "organic_paywall"
            return .load(from: .subscription)

        }
        
        // Show automaticly distributed paywall
        
        print("GLOBAL APP INSTALLS DEBUG | Global install number - \(State.globalAppInstalls)")
        
        switch State.globalAppInstalls % 3 {
            
        case 1:
            print("PAYWALLS DEBUG | Auto paywall number - 1")
            State.firstSubscriptionPage = self.firstSubscriptionPage()
            SkarbSDK.sendSource(broker: SKBroker.custom("first_paywall"), features: [:])
            State.currentPaywall = "first_paywall"
            return .load(from: .subscriptionFirst)
        case 2:
            print("PAYWALLS DEBUG | Auto paywall number - 2")
            State.secondSubscriptionPage = self.secondSubscriptionPage()
            SkarbSDK.sendSource(broker: SKBroker.custom("second_paywall"), features: [:])
            State.currentPaywall = "second_paywall"
            return .load(from: .subscriptionSecond)
        case 0:
            print("PAYWALLS DEBUG | Auto paywall number - 3")
            State.thirdSubscriptionPage = self.thirdSubscriptionPage()
            SkarbSDK.sendSource(broker: SKBroker.custom("third_paywall"), features: [:])
            State.currentPaywall = "third_paywall"
            return .load(from: .subscriptionThird)
        default:
            print("PAYWALLS DEBUG | Auto paywall number - 0")
            State.subscriptionConfig = self.organicSubscriptionPage()
            SkarbSDK.sendSource(broker: SKBroker.custom("organic_paywall"), features: [:])
            State.currentPaywall = "organic_paywall"
            return .load(from: .subscription)
            
        }
        
    }
    
    func automaticPaywallDistribution() -> Bool {
        
        let key = RCValueKey.automaticPaywallDistribution.rawValue
        let automaticPaywallDistribution: Bool = RemoteConfig.remoteConfig()[key].boolValue
        
        print("PAYWALLS DEBUG | Automatic Paywall Distribution - \(automaticPaywallDistribution)")
        
        return automaticPaywallDistribution
        
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
