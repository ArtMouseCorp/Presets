import Foundation

struct ThirdSubscriptionPage {
    
    let titleLabel: String
    let subtitleLabel: String
    let priceLabel: String
    let subscribeButtonLabel: String
    let features: [String]
    let closeDelay: Int
    let showTerms: Bool
    let subscriptionId: String
    
    public static let `default` = ThirdSubscriptionPage(
        titleLabel: "Full Access to the application",
        subtitleLabel: "Join the application to unlock additional features, get access to all presets",
        priceLabel: "%trial_period% free, then %subscription_price% / %subscription_period%",
        subscribeButtonLabel: "Start and Subscribe",
        features: [
            "Get access to 100+ presets",
            "Without advertising",
            "New presets every month"
        ],
        closeDelay: 2,
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
