import UIKit

class LoadingViewController: BaseViewController {
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreManager.updateStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            // Load data
            _ = RCValues.sharedInstance.currentPaywall()
            _ = RCValues.sharedInstance.currentPaywall()
            
            if !State.isSubscribed {
                let paywall = RCValues.sharedInstance.currentPaywall()
                paywall.source = .launch
                paywall.modalPresentationStyle = .fullScreen
                self.present(paywall, animated: true)
            } else {
                let mainNavController = UINavigationController.load(from: .mainNav)
                mainNavController.modalPresentationStyle = .fullScreen
                self.present(mainNavController, animated: true, completion: nil)
            }
            
        }
    }
    
}
