import UIKit
import Purchases
import Amplitude
import StoreKit

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
                
                for package in packages {
                    
                    // Get a reference to a product
                    let product = package.product
                    
                    guard productIds.contains(product.productIdentifier) else { continue }
                    
                    // Product price
                    let price = product.localizedPrice ?? product.price.stringValue
                    
                    let subscriptionPeriod = product.getSubscriptionPeriod()
                    let trialPeriod = product.getTrialPeriod()
                    
                    let customProduct = Product(id: product.productIdentifier, price: price, subscriptionPeriod: subscriptionPeriod, trialPeriod: trialPeriod, purchasesPackage: package, skProduct: product)
                    
                    foundProducts.append(customProduct)
                }
                
                completion(foundProducts)
                
            }
            
        }
        
    }
    
    public static func purchase(package: Purchases.Package, completion: (() -> ())? = nil) {

        Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
            if purchaserInfo?.entitlements[self.entitlementId]?.isActive == true {
                
                print("Purchase Success: \(package.product.productIdentifier)")
                
                Amplitude.instance().logEvent("Subscription purchased",
                                              withEventProperties: [
                                                "Transaction identifier": transaction?.transactionIdentifier ?? "",
                                                "Transaction date": transaction?.transactionDate ?? Date(),
                                                "Transaction product identifier": transaction?.payment.productIdentifier ?? ""
                                              ])
                
                State.isSubscribed = true
                completion?() ?? ()
            }
            
        }
        
    }
    
    public static func restore(completion: (() -> ())? = nil) {
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            //... check purchaserInfo to see if entitlement is now active
            guard let purchaserInfo = purchaserInfo, error == nil else {
                return
            }
            
            if purchaserInfo.entitlements[self.entitlementId]?.isActive == true {
                
                State.isSubscribed = true
                activeController().showRestoredAlert() {
                    completion?() ?? ()
                }
                
            } else {
                activeController().showNotSubscriberAlert(completion: nil)
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
