import UIKit

struct OrganicSubscriptionPage: Codable {
    
    let titleLabel: String
    let subtitleLabel: String
    let closeDelay: CGFloat
    let priceLabel: String
    let priceLabelFontSize: CGFloat
    let priceLabelOpacity: CGFloat
    let buttonLabel: String
    let buttonFontSize: CGFloat
    let showTerms: Bool
    let subscriptionId: String
    
    
    public static let `default` = OrganicSubscriptionPage(
        titleLabel: "Become Pro!",
        subtitleLabel: "Over 100+ quality presets",
        closeDelay: 2,
        priceLabel: "%trial_period% FREE, then %subscription_price% / %subscription_period%",
        priceLabelFontSize: 16,
        priceLabelOpacity: 1,
        buttonLabel: "Start & Subscribe",
        buttonFontSize: 16,
        showTerms: true,
        subscriptionId: "com.artpol.presets.week"
    )
    
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
