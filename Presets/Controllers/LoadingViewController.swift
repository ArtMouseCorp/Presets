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
            
            let mainNavController = UINavigationController.load(from: .mainNav)
            mainNavController.modalPresentationStyle = .fullScreen
            self.present(mainNavController, animated: true, completion: nil)
            
        }
    }
    
}
