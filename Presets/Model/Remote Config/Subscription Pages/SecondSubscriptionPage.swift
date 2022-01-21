import Foundation

struct SecondSubscriptionPage {
    
    let titleLabel: String
    let subtitleLabel: String
    let subscribeButtonLabel: String
    let economyLabel: String
    let closeDelay: Int
    let showTerms: Bool
    
    let firstProduct: Product
    let secondProduct: Product
    
    internal struct Product {
        let priceLabel: String
        let totalPriceLabel: String?
        let subscriptionId: String
    }
    
    public static let `default` = SecondSubscriptionPage(
        titleLabel: "Edit professionally",
        subtitleLabel: "Using 1,125 presets",
        subscribeButtonLabel: "Continue",
        economyLabel: "Economy 80%",
        closeDelay: 2,
        showTerms: true,
        firstProduct: Product(
            priceLabel: "%numbered_subscription_period%: %monthly_price% / month",
            totalPriceLabel: "Total %subscription_price%",
            subscriptionId: "com.artpol.presets.year"
        ),
        secondProduct: Product(
            priceLabel: "%numbered_subscription_period%: %subscription_price% / %subscription_period%",
            totalPriceLabel: nil,
            subscriptionId: "com.artpol.presets.month"
        )
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
