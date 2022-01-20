import Foundation

struct SaleSubscriptionPage {
    
    let smallSaleOfferView: SmallSaleOfferView
    
    let titleLabel: String
    let saleLabel: String
    let limitedWarningLabel: String
    let priceLabel: String
    let subscriptionButtonLabel: String
    let timeLeftLabel: String
    let saleDurationSeconds: Int
    let subscriptionId: String
    
    public static let `default` = SaleSubscriptionPage(
        smallSaleOfferView: SmallSaleOfferView.default,
        titleLabel: "Get 1125\nLightroom Presets",
        saleLabel: "SALE 50%",
        limitedWarningLabel: "Limited offer",
        priceLabel: "Get all presets for %$19.99% for only %subscription_price% per %subscription_period%",
        subscriptionButtonLabel: "Continue",
        timeLeftLabel: "🔥 Until the end of the offer left",
        saleDurationSeconds: 10800,
        subscriptionId: "com.artpol.presets.week"
    )
    
    internal struct SmallSaleOfferView {
        let titleLabel: String
        let descriptionLabel: String
        let buttonLabel: String
        
        public static let `default` = SmallSaleOfferView(
            titleLabel: "Sale: -50%",
            descriptionLabel: "All presets, highlights and effects",
            buttonLabel: "GET"
        )
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
