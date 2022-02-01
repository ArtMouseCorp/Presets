import UIKit
import Purchases
import Amplitude
import StoreKit
import AppsFlyerLib

struct StoreManager {
    
    private static let entitlementId = Keys.RevenueCat.entitlementId
    
    struct Product {
        var id: String
        var price: String
        var subscriptionPeriod: String
        var trialPeriod: String?
        var purchasesPackage: Purchases.Package
        var skProduct: SKProduct
    }
    
    public static func updateStatus(completion: (() -> ())? = nil) {
        
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements.all[self.entitlementId]?.isActive == true {
                State.isSubscribed = true
                completion?() ?? ()
                return
            }
            State.isSubscribed = false
            completion?() ?? ()
        }
        
    }
    
    public static func getProducts(for productIds: [String], completion: @escaping (([Product]) -> ())) {
        
        var foundProducts: [StoreManager.Product] = []
        
        Purchases.shared.offerings { offerings, erro in
            
            if let packages = offerings?.current?.availablePackages {
                
                for productId in productIds {
                    
                    for package in packages {
                        
                        // Get a reference to a product
                        let product = package.product
                        
                        guard productId == product.productIdentifier else { continue }
                        
                        // Product price
                        let price = product.localizedPrice ?? product.price.stringValue
                        
                        let subscriptionPeriod = product.getSubscriptionPeriod()
                        let trialPeriod = product.getTrialPeriod()
                        
                        let customProduct = Product(id: product.productIdentifier, price: price, subscriptionPeriod: subscriptionPeriod, trialPeriod: trialPeriod, purchasesPackage: package, skProduct: product)
                        
                        foundProducts.append(customProduct)
                    }
                    
                }
                
                completion(foundProducts)
                
            }
            
        }
        
    }
    
    public static func purchase(package: Purchases.Package, completion: (() -> ())? = nil) {
        
        topController().showLoader()
        
        Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
            
            topController().hideLoader()
            
            if purchaserInfo?.entitlements[self.entitlementId]?.isActive == true {
                
                print("Purchase Success: \(package.product.productIdentifier)")
                ProdinfireManager.sharedInstance.sendSubscribtionEvent(subscibedTo: package.product.productIdentifier)
                
                Amplitude.instance().logEvent("subscription_purchase",
                                              withEventProperties: [
                                                "transaction_identifier": transaction?.transactionIdentifier ?? "",
                                                "transaction_date": transaction?.transactionDate ?? Date(),
                                                "transaction_product_identifier": transaction?.payment.productIdentifier ?? "",
                                                "paywall_name": State.currentPaywall
                                              ])
                
                AppsFlyerLib.shared().logEvent("subscription_purchase",
                                               withValues: [
                                                "transaction_identifier": transaction?.transactionIdentifier ?? "",
                                                "transaction_date": transaction?.transactionDate ?? Date(),
                                                "transaction_product_identifier": transaction?.payment.productIdentifier ?? "",
                                                "paywall_name": State.currentPaywall
                                               ])
                
                State.isSubscribed = true
                completion?() ?? ()
            }
            
        }
        
    }
    
    public static func restore(completion: (() -> ())? = nil) {
        
        topController().showLoader()
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            
            topController().hideLoader() {
                
                //... check purchaserInfo to see if entitlement is now active
                guard let purchaserInfo = purchaserInfo, error == nil else {
                    return
                }
                
                if purchaserInfo.entitlements[self.entitlementId]?.isActive == true {
                    
                    State.isSubscribed = true
                    topController().showRestoredAlert() {
                        completion?() ?? ()
                    }
                    
                } else {
                    topController().showNotSubscriberAlert()
                }
                
            }
            
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
