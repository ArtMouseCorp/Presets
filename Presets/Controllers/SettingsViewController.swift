import UIKit

class SettingsViewController: BaseViewController {

    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var howToUseLabel: UILabel!
    @IBOutlet weak var termsOfServicesLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var subscriptionTermsLabel: UILabel!
    @IBOutlet weak var recoverPurchaseLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButon: UIButton!
    
    // Views
    @IBOutlet weak var howToUseView: UIView!
    @IBOutlet weak var termsOfServicesView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var subscriptionTermsView: UIView!
    @IBOutlet weak var recoverPurchaseView: UIView!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
    }
    
    // MARK: - Custom functions
    
    func configureGestures() {
        // HOW TO USE
        let tapHowToUse = UITapGestureRecognizer(target: self, action: #selector(howToUseTapped))
        howToUseView.addGestureRecognizer(tapHowToUse)
        
        // TERMS OF SERVICES
        let tapTermsOfServices = UITapGestureRecognizer(target: self, action: #selector(termsOfServicesTapped))
        termsOfServicesView.addGestureRecognizer(tapTermsOfServices)
        
        // PRIVACY POLICY
        let tapPrivacyPolicy = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyTapped))
        privacyPolicyView.addGestureRecognizer(tapPrivacyPolicy)
        
        // SUBSCRIPTION TERMS
        let tapSubscriptionTerms = UITapGestureRecognizer(target: self, action: #selector(subscriptionTermsTapped))
        subscriptionTermsView.addGestureRecognizer(tapSubscriptionTerms)
        
        // RECOVER PURCHASE
        let tapRecoverPurchase = UITapGestureRecognizer(target: self, action: #selector(recoverPurchaseTapped))
        recoverPurchaseView.addGestureRecognizer(tapRecoverPurchase)
        
    }
    
    // MARK: - Gesture actions
    
    @objc func howToUseTapped() {
        let manualVC = ManualViewController.load(from: .manual)
        self.navigationController?.pushViewController(manualVC, animated: true)
    }
    
    @objc func termsOfServicesTapped() {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Terms of Service"
        self.showPopup(popup)
    }
    
    @objc func privacyPolicyTapped() {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Privacy Policy"
        self.showPopup(popup)
    }
    
    @objc func subscriptionTermsTapped() {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Subscription Terms"
        self.showPopup(popup)
    }
    
    @objc func recoverPurchaseTapped() {

    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
