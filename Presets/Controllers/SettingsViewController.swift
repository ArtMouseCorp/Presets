import UIKit
import SwiftyStoreKit

class SettingsViewController: BaseViewController {

    // Views
    @IBOutlet weak var howToUseView: UIView!
    @IBOutlet weak var termsOfServicesView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var recoverPurchaseView: UIView!
    @IBOutlet weak var subscriptionPlansView: UIView!

    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var howToUseLabel: UILabel!
    @IBOutlet weak var termsOfServicesLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var recoverPurchaseLabel: UILabel!
    @IBOutlet weak var subscriptionPlansLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButon: UIButton!
                
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        configureGestures()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.titleLabel.localize(with: L10n.Settings.title)
        self.howToUseLabel.localize(with: L10n.Settings.Button.manual)
        self.termsOfServicesLabel.localize(with: L10n.Settings.Button.serviceTerms)
        self.privacyPolicyLabel.localize(with: L10n.Settings.Button.policy)
        self.contactLabel.localize(with: L10n.Settings.Button.contact)
        self.recoverPurchaseLabel.localize(with: L10n.Settings.Button.restorePurchase)
    }
    
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
        let tapContact = UITapGestureRecognizer(target: self, action: #selector(contactTapped))
        contactView.addGestureRecognizer(tapContact)
        
        // RECOVER PURCHASE
        let tapRecoverPurchase = UITapGestureRecognizer(target: self, action: #selector(recoverPurchaseTapped))
        recoverPurchaseView.addGestureRecognizer(tapRecoverPurchase)
        
        // SUBSCRIPTION PLANS
        let tapSubscriptionPlans = UITapGestureRecognizer(target: self, action: #selector(subscriptionPlansTapped))
        subscriptionPlansView.addGestureRecognizer(tapSubscriptionPlans)
    }
    
    // MARK: - Gesture actions
    
    @objc func howToUseTapped() {
        let manualVC = ManualViewController.load(from: .manual)
        self.navigationController?.pushViewController(manualVC, animated: true)
    }
    
    @objc func termsOfServicesTapped() {
//        let popup = SettingsPopupViewController.load(from: .settingsPopup)
//        popup.titleLabelText = L10n.ServiceTerms.title
//        popup.mainText = FullTermsOfUse
//        self.showPopup(popup)
        guard let url = URL(string: "https://artpoldev.com/terms.html") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func privacyPolicyTapped() {
//        let popup = SettingsPopupViewController.load(from: .settingsPopup)
//        popup.titleLabelText = L10n.Privacy.title
//        popup.mainText = FullPrivacyPolicy
//        self.showPopup(popup)
        
        guard let url = URL(string: "https://artpoldev.com/privacy.html") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func contactTapped() {
        guard let url = URL(string: "https://artpoldev.com/#contact") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func recoverPurchaseTapped() {
        
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                
                State.isSubscribed = false
                
            } else if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoredPurchases)")
                
                State.isSubscribed = true
                self.showRestoredAlert(completion: nil)
                
            } else {
                print("Nothing to Restore")
                
                State.isSubscribed = false
                self.showNotSubscriberAlert(completion: nil)
                
            }
        }
        
    }
    
    @objc private func subscriptionPlansTapped() {
        
        let subscriptionPlansVC = SubscriptionPlansViewController.load(from: .subscriptionPlans)
        self.navigationController?.pushViewController(subscriptionPlansVC, animated: true)
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

