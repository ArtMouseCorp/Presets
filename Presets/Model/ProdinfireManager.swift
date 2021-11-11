import Foundation
import Alamofire

class ProdinfireManager {
    
    public static let sharedInstance: ProdinfireManager = ProdinfireManager()
    
    private var appsFlyerConversationData: [String: Any] = [:]
    
    public func isInstallEventSent() -> Bool {
        return userDefaults.bool(forKey: UDKeys.isInstallEventSent)
    }
    
    public func setInstallEventSent(to isSent: Bool) {
        userDefaults.set(isSent, forKey: UDKeys.isInstallEventSent)
    }
    
    public func setAppsFlyerConversation(to conversationInfo: [AnyHashable: Any]) -> Void {
        appsFlyerConversationData.removeAll()
        conversationInfo.forEach { element in
            if let key = element.key as? String {
                appsFlyerConversationData[key] = element.value
            }
        }
    }
    
    public func sendInstallEvent() {
        
        let parameters: [String: Any] = [
            "api_key": Keys.Prodinfire.apiKey,
            "event": "install",
            "af_data": appsFlyerConversationData
        ]
        
        
        print("Install event params: ", parameters)
        
        self.setInstallEventSent(to: true)
        postRequest(parameters: parameters)
        
    }
    
    public func sendSubscribtionEvent(subscibedTo productId: String) {
        
        let parameters: [String: Any] = [
            "api_key": Keys.Prodinfire.apiKey,
            "event": "subscribe",
            "product": productId,
            "af_data": appsFlyerConversationData
        ]
        
        print("Subscription event params: ", parameters)
        
        postRequest(parameters: parameters)
        
    }
    
    private func postRequest(parameters: [String: Any]) {
        
        AF.request(Keys.Prodinfire.url, method:.post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                print("Prodinfire event response: ", response)
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
