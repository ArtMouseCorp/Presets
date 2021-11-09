import Foundation
import Alamofire

class ProdinfireManager {
    
    public static let sharedInstance: ProdinfireManager = ProdinfireManager()
    
    private var appsFlyerConversations: [String: String]? = nil
    
    public func setAppsFlyerConversation(to conversationInfo: [AnyHashable: Any]) -> Void {
        appsFlyerConversations?.removeAll()
        conversationInfo.forEach { element in
            appsFlyerConversations?[element.key as! String] = (element.value as! String)
        }
    }
    
    public func sendInstallEvent() {
        
        let parameters: [String: Any] = [
            "api_key": Keys.Prodinfire.apiKey,
            "event": "install",
            "af_data": appsFlyerConversations as Any
        ]
        
        postRequest(params: parameters)
        
    }
    
    public func sendSubscribtionEvent(subscibedTo productId: String) {
        
        let parameters: [String: Any] = [
            "api_key": Keys.Prodinfire.apiKey,
            "event": "subscribe",
            "product": productId,
            "af_data": appsFlyerConversations as Any
        ]
        
        postRequest(params: parameters)
        
    }
    
    private func postRequest(params: [String: Any]) {
        
        
        var jsonData:Data?
        do {
            jsonData = try JSONSerialization.data(
                withJSONObject: params,
                options: .prettyPrinted
            )
        } catch {
            print(error.localizedDescription)
        }
        
        // create post request
        let url = NSURL(string: Keys.Prodinfire.url)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData! as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil {
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                
                print("Prodinfire Event Result", result!)
                
            } catch {
                print("Prodinfire Event Error -> \(error)")
            }
        }
        
        task.resume()
        
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
