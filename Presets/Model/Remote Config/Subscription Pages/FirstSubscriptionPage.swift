import Foundation

struct FirstSubscriptionPage {
    
    let titleLabel: String
    let trialOnLabel: String
    let trialOffLabel: String
    let isTrialOn: Bool
    let priceLabel: String
    let subscribeButtonLabel: String
    let closeDelay: Int
    let showTerms: Bool
    let trialSubscriptionId: String
    let noTrialSubscriptionId: String
    
    public static let `default` = FirstSubscriptionPage(
        titleLabel: "Unlimited access",
        trialOnLabel: "%trial_period% Trial On",
        trialOffLabel: "%trial_period% Trial Off",
        isTrialOn: true,
        priceLabel: "Auto-renew at %subscription_price% / %subscription_period%",
        subscribeButtonLabel: "Continue",
        closeDelay: 2,
        showTerms: true,
        trialSubscriptionId: "com.artpol.presets.week",
        noTrialSubscriptionId: "com.artpol.presets.month"
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
