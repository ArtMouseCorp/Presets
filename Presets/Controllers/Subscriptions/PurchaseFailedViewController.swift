import UIKit

class PurchaseFailedViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var blackWhiteGradient: UIView!

    // Labels
    @IBOutlet weak var oopsLabel: UILabel!
    @IBOutlet weak var purchaseFailedLabel: UILabel!
    @IBOutlet weak var viewAdsLabel: UILabel!
    @IBOutlet weak var purchaseRunLimitedLabel: UILabel!
    @IBOutlet weak var tryThreeDaysLabel: UILabel!
    @IBOutlet weak var cancelOrPauseLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var tryThreeDaysButton: BlueGradientButton!
    
    // MARK: - Variables
    
    var completion: (() -> ())!
    var didLayoutCounter = true
    var closeButtonIsHidden = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.isHidden = closeButtonIsHidden
    }
    
    override func viewDidLayoutSubviews() {
        if didLayoutCounter {
            configureGradients()
            didLayoutCounter = false
        }
    }
    
    // MARK: - Custom functions
    
    func configureGradients() {
        blackWhiteGradient.applyGradient(colors: [
            CGColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 0.88),
            CGColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 0)
        ], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
        completion()
    }
    
    @IBAction func tryThreeDaysButtonPressed(_ sender: Any) {
        // TODO: - Start free trial period
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        // TODO: - Restore purchase
    }
    
    @IBAction func privacyButtonPressed(_ sender: Any) {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Privacy Policy"
        popup.mainText = FullPrivacyPolicy
        self.showPopup(popup)
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Terms of Service"
        popup.mainText = FullTermsOfUse
        self.showPopup(popup)
    }
    
}
