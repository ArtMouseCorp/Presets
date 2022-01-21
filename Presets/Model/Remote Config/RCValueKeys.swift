import Foundation

enum RCValueKey: String {
    case organicSubscriptionPage = "org_sub_page"
    case subscriptionPlansPage = "sub_plans_page"
    
    case saleSubscriptionsPage = "sale_sub_page"
    
    case firstSubscriptionPage = "first_sub_page"
    case secondSubscriptionPage = "second_sub_page"
    case thirdSubscriptionPage = "third_sub_page"
    
    case currentPaywall
    case automaticPaywallDistribution
    
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
    
    internal enum FirstSubscriptionPage: String {
        case titleLabel
        case trialOnLabel
        case trialOffLabel
        case isTrialOn
        case priceLabel
        case subscribeButtonLabel
        case closeDelay
        case showTerms
        case trialSubscriptionId
        case noTrialSubscriptionId
    }
    
    internal enum SecondSubscriptionPage: String {
        case titleLabel
        case subtitleLabel
        case subscribeButtonLabel
        case economyLabel
        case closeDelay
        case showTerms
        case firstProduct
        case secondProduct
        
        internal enum Product: String {
            case priceLabel
            case totalPriceLabel
            case subscriptionId
        }
    }
    
    internal enum ThirdSubscriptionPage: String {
        case titleLabel
        case subtitleLabel
        case priceLabel
        case subscribeButtonLabel
        case features
        case closeDelay
        case showTerms
        case subscriptionId
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
