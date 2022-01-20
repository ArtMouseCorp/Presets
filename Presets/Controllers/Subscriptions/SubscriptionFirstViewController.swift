import UIKit
import Amplitude
import GoogleMobileAds

class SubscriptionFirstViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trialLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var continueButton: BlueGradientButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // Stack Views
    @IBOutlet weak var bottomButtonsStackView: UIStackView!
    
    // Switch
    @IBOutlet weak var isTrialOffSwitch: UISwitch!
    
    // Activity Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    var interstitial: GADInterstitialAd?
    
    let pageConfig: FirstSubscriptionPage = State.firstSubscriptionPage
    
    var trialProduct: StoreManager.Product?
    var noTrialProduct: StoreManager.Product?
        
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        createAndLoadInterstitialAd()
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showCloseButton()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.restoreButton.localize(with: L10n.Subscription.Button.restore)
        self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
        self.termsButton.localize(with: L10n.Subscription.Button.terms)
        
        titleLabel.localize(with: pageConfig.titleLabel)
        continueButton.localize(with: pageConfig.subscribeButtonLabel)
        
    }
    
    private func configureUI() {
        self.closeButton.hide()
        self.bottomButtonsStackView.hide(!pageConfig.showTerms)
    }
    
    private func showCloseButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(pageConfig.closeDelay)) {
            self.closeButton.show()
        }
    }
    
    private func createAndLoadInterstitialAd() {
        
        let request = GADRequest()
        
        GADInterstitialAd.load(withAdUnitID: Keys.AdmMod.unitId, request: request) { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        
    }
    
    private func showInterstitialAd() {
        
        guard let interstitial = interstitial else {
            print("Ad wasn't ready")
            self.view.removeFromSuperview()
            return
        }
        
        interstitial.present(fromRootViewController: self)
        Amplitude.instance().logEvent(AmplitudeEvents.afterSubscriptionAd)
    }
    
    private func getProducts() {
        
        guard isConnectedToNetwork() else {
            showNetworkConnectionAlert {
                self.view.removeFromSuperview()
            }
             return
        }
        
        isTrialOffSwitch.hide()
        trialLabel.hide()
        priceLabel.hide()
        continueButton.isEnabled = false
        restoreButton.isEnabled = false
        
        let ids = ["com.temporary.week", "com.temporary.month"] // DEBUG
//        let ids = [pageConfig.trialSubscriptionId, pageConfig.noTrialSubscriptionId] // RELEASE
        
        StoreManager.getProducts(for: ids) { products in
            
            guard products.count == 2 else {
                self.view.removeFromSuperview()
                return
            }
            
            self.trialProduct = products[0]
            self.noTrialProduct = products[1]
            
            DispatchQueue.main.async {
                self.updateSubscriptionsUI()
            }
            
        }
           
    }
    
    private func updateSubscriptionsUI() {
        
        guard let trialProduct = trialProduct else {
            self.view.removeFromSuperview()
            return
        }
        
        if let trialPeriod = trialProduct.trialPeriod {
            trialLabel.text = pageConfig.trialOnLabel
                .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
                .lowercased()
            trialLabel.show()
        }
        
        priceLabel.text = pageConfig.priceLabel
            .replacingOccurrences(of: "%subscription_price%", with: trialProduct.price)
            .replacingOccurrences(of: "%subscription_period%", with: trialProduct.subscriptionPeriod)
        
        activityIndicator.stopAnimating()
        isTrialOffSwitch.show()
        priceLabel.show()
        continueButton.isEnabled = true
        restoreButton.isEnabled = true
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        Amplitude.instance().logEvent(AmplitudeEvents.paywallClose)
        
        guard State.isSubscribed else {
            showInterstitialAd()
            return
        }
        
        self.view.removeFromSuperview()
    }
    
    @IBAction func trialSwitchValueChanged(_ sender: Any) {
        
        guard
            let trialProduct = trialProduct,
            let noTrialProduct = noTrialProduct
        else {
            return
        }
        
        if isTrialOffSwitch.isOn {
            
            if let trialPeriod = trialProduct.trialPeriod {
                trialLabel.text = pageConfig.trialOnLabel
                    .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
                    .lowercased()
            }
            priceLabel.text = pageConfig.priceLabel
                .replacingOccurrences(of: "%subscription_price%", with: trialProduct.price)
                .replacingOccurrences(of: "%subscription_period%", with: trialProduct.subscriptionPeriod)
            
        } else {
            
            if let trialPeriod = trialProduct.trialPeriod {
                trialLabel.text = pageConfig.trialOffLabel
                    .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
                    .lowercased()
            }
            
            priceLabel.text = pageConfig.priceLabel
                .replacingOccurrences(of: "%subscription_price%", with: noTrialProduct.price)
                .replacingOccurrences(of: "%subscription_period%", with: noTrialProduct.subscriptionPeriod)
            
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {

        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        guard let product = isTrialOffSwitch.isOn ? trialProduct : noTrialProduct else {
            return
        }
        
        Amplitude.instance().logEvent(AmplitudeEvents.subscriptionButtonTap)
        
        StoreManager.purchase(package: product.purchasesPackage) {
            self.view.removeFromSuperview()
        }
        
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard isConnectedToNetwork() else {
            showNetworkConnectionAlert()
            return
        }
        
        guard !State.isSubscribed else {
            showAlreadySubscribedAlert()
            return
        }
        
        StoreManager.restore() {
            self.view.removeFromSuperview()
        }
        
    }
    
    @IBAction func privacyButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard let url = URL(string: "https://artpoldev.com/privacy.html") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard let url = URL(string: "https://artpoldev.com/terms.html") else { return }
        UIApplication.shared.open(url)
    }
    
}

// MARK: - GADFullScreenContentDelegate

extension SubscriptionFirstViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
        self.view.removeFromSuperview()
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will dismiss full screen content.")
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
