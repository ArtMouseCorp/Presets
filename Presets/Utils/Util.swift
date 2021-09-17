import UIKit
import SwiftyStoreKit
import SystemConfiguration

func getGradientColor(bounds: CGRect, colors: [CGColor]) -> UIColor? {
    
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = colors
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    
    UIGraphicsBeginImageContext(gradient.bounds.size)
    //create UIImage by rendering gradient layer.
    gradient.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    //get gradient UIcolor from gradient UIImage
    return UIColor(patternImage: image!)
}

public func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

public func getLocalImage(forName name: String, ofType type: String) -> UIImage? {
    
    if let filePath = Bundle.main.path(forResource: name, ofType: type) {
        return UIImage(contentsOfFile: filePath)
    }
    return nil
}

public func print(_ toPring: Any) {
    
    print("\n\n\n", toPring, "\n\n\n")
    
}

func getNoun(number: Int, one: String, two: String, five: String) -> String {
    var n = abs(number)
    n %= 100
    if (n >= 5 && n <= 20) {
        return five
    }
    n %= 10
    if (n == 1) {
        return one
    }
    if (n >= 2 && n <= 4) {
        return two
    }
    return five
}

public func getAlert(title: String, message: String, actions: UIAlertAction...) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions.forEach { action in
        alert.addAction(action)
    }
    return alert
}

public func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
    
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    
    return ret
    
}

public func checkSubscription() {
    
    // TODO: - Pass right SHARED SECRET and PRODUCT ID
    
    let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "your-shared-secret")
    SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
        switch result {
        case .success(let receipt):
            let productId = State.currentProductId
            // Verify the purchase of a Subscription
            let purchaseResult = SwiftyStoreKit.verifySubscription(
                ofType: .autoRenewable,
                productId: productId,
                inReceipt: receipt)
                
            switch purchaseResult {
            case .purchased(let expiryDate, let items):
                print("\(productId) is valid until \(expiryDate)\n\(items)\n")
                State.isSubscribed = true
            case .expired(let expiryDate, let items):
                print("\(productId) is expired since \(expiryDate)\n\(items)\n")
                State.isSubscribed = false
            case .notPurchased:
                print("The user has never purchased \(productId)")
                State.isSubscribed = false
            }

        case .error(let error):
            print("Receipt verification failed: \(error)")
            State.isSubscribed = false
        }
    }

    
}
