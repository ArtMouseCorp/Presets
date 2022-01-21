import UIKit
import Amplitude
import GoogleMobileAds
import StoreKit

class SubscriptionSecondViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var firstSubscriptionView: UIView!
    @IBOutlet weak var secondSubscriptionView: UIView!
    @IBOutlet weak var saveView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var firstSubscriptionPriceLabel: UILabel!
    @IBOutlet weak var firstSubscriptionTotalLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var secondSubscriptionPriceLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var continueButton: BlueGradientButton!
    
    // Stack Views
    @IBOutlet weak var bottomButtonsStackView: UIStackView!
    
    // Image Views
    @IBOutlet weak var firstSubscriptionTickImage: UIImageView!
    @IBOutlet weak var secondSubscriptionTickImage: UIImageView!
    
    // Activity Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    let tickOnImage = UIImage(named: "tick-white")
    let tickOffImage = UIImage(named: "tick-empty")
    var isFirstSub = true
    
    var interstitial: GADInterstitialAd?
    
    let pageConfig: SecondSubscriptionPage = State.secondSubscriptionPage
    
    var firstProduct: StoreManager.Product?
    var secondProduct: StoreManager.Product?
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        createAndLoadInterstitialAd()
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
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
        subtitleLabel.localize(with: pageConfig.subtitleLabel)
        continueButton.localize(with: pageConfig.subscribeButtonLabel)
    }
    
    private func configureUI() {
        firstSubscriptionView.layer.cornerRadius = 11
        firstSubscriptionView.layer.borderWidth = 1
        secondSubscriptionView.layer.cornerRadius = 11
        secondSubscriptionView.layer.borderWidth = 1
        firstSubscriptionView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        secondSubscriptionView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
        saveView.layer.cornerRadius = 12
        saveView.clipsToBounds = true
        saveView.applyGradient(colors: [
            CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
            CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1)
        ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: saveView.bounds.insetBy(dx: 0, dy: -1 * saveView.bounds.size.height))
        
        self.closeButton.hide()
        self.bottomButtonsStackView.hide(!pageConfig.showTerms)
    }
    
    private func setupGestures() {
        firstSubscriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstSubscriptionViewTapped)))
        secondSubscriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondSubscriptionViewTapped)))
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
        
        
        firstSubscriptionView.hide()
        secondSubscriptionView.hide()
        continueButton.isEnabled = false
        restoreButton.isEnabled = false
        
//        let ids = ["com.temporary.year", "com.temporary.month"] // DEBUG
        let ids = [pageConfig.firstProduct.subscriptionId, pageConfig.secondProduct.subscriptionId] // RELEASE
        
        StoreManager.getProducts(for: ids) { products in
            
            guard products.count == 2 else {
                self.view.removeFromSuperview()
                return
            }
            
            self.firstProduct = products[0]
            self.secondProduct = products[1]
            
            DispatchQueue.main.async {
                self.updateSubscriptionsUI()
            }
            
        }
        
    }
    
    private func updateSubscriptionsUI() {
        
        guard
            let firstProduct = firstProduct,
            let secondProduct = secondProduct
        else {
            self.view.removeFromSuperview()
            return
        }
        
        var firstProductMonthlyPrice: Double = 0
        
        switch firstProduct.skProduct.subscriptionPeriod?.unit {
        case .day: firstProductMonthlyPrice = firstProduct.skProduct.price.doubleValue * 30
        case .week: firstProductMonthlyPrice = firstProduct.skProduct.price.doubleValue * 4
        case .month: firstProductMonthlyPrice = firstProduct.skProduct.price.doubleValue
        case .year: firstProductMonthlyPrice = firstProduct.skProduct.price.doubleValue / 12
        default: firstProductMonthlyPrice = firstProduct.skProduct.price.doubleValue
        }
        
        let formatter = SKProduct.formatter
        formatter.locale = firstProduct.skProduct.priceLocale
        let firstProductMonthlyPriceString = formatter.string(from: NSNumber(value: firstProductMonthlyPrice))
        
        firstSubscriptionPriceLabel.text = pageConfig.firstProduct.priceLabel
            .replacingOccurrences(of: "%numbered_subscription_period%", with: firstProduct.skProduct.getSubscriptionPeriod(showUnits: true))
            .replacingOccurrences(of: "%monthly_price%", with: firstProductMonthlyPriceString ?? firstProduct.price)
        
        if let totalPrice = pageConfig.firstProduct.totalPriceLabel {
            firstSubscriptionTotalLabel.text = totalPrice
                .replacingOccurrences(of: "%subscription_price%", with: firstProduct.price)
        }
        
        secondSubscriptionPriceLabel.text = pageConfig.secondProduct.priceLabel
            .replacingOccurrences(of: "%numbered_subscription_period%", with: secondProduct.skProduct.getSubscriptionPeriod(showUnits: true))
            .replacingOccurrences(of: "%subscription_price%", with: secondProduct.price)
            .replacingOccurrences(of: "%subscription_period%", with: secondProduct.subscriptionPeriod)
        
        saveLabel.text = pageConfig.economyLabel
        
        activityIndicator.stopAnimating()
        firstSubscriptionView.show()
        secondSubscriptionView.show()
        continueButton.isEnabled = true
        restoreButton.isEnabled = true
        
    }
    
    // MARK: - Gesture actions
    
    @objc func firstSubscriptionViewTapped() {
        if !isFirstSub {
            firstSubscriptionView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            secondSubscriptionView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
            firstSubscriptionTickImage.image = tickOnImage
            secondSubscriptionTickImage.image = tickOffImage
            isFirstSub = true
        }
    }
    
    @objc func secondSubscriptionViewTapped() {
        if isFirstSub {
            firstSubscriptionView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
            secondSubscriptionView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            firstSubscriptionTickImage.image = tickOffImage
            secondSubscriptionTickImage.image = tickOnImage
            isFirstSub = false
        }
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
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        let productSubscription = isFirstSub ? firstProduct : secondProduct
        
        guard let product = productSubscription else { return }
        
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
            self.dismiss(animated: true)
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

extension SubscriptionSecondViewController: GADFullScreenContentDelegate {
    
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
