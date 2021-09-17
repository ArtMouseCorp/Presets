import UIKit

struct SubscriptionPlansPage: Codable {
    
    let titleLabel: String
    let subtitleLabel: String
    let closeDelay: Double
    let priceLabelFontSize: CGFloat
    let priceLabelOpacity: CGFloat
    let buttonLabel: String
    let buttonFontSize: CGFloat
    let showTerms: Bool
    let firstSubscriptionId: String
    let secondSubscriptionId: String
    let thirdSubscriptionId: String
    
    
    public static let `default` = SubscriptionPlansPage(
        titleLabel: "Become Pro!",
        subtitleLabel: "Over 100+ quality presets",
        closeDelay: 2,
        priceLabelFontSize: 16,
        priceLabelOpacity: 1,
        buttonLabel: "Start & Subscribe",
        buttonFontSize: 16,
        showTerms: true,
        firstSubscriptionId: "com.artpol.presets.week",
        secondSubscriptionId: "com.artpol.presets.month",
        thirdSubscriptionId: "com.artpol.presets.year"
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
