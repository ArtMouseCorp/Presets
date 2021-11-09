import UIKit
import Purchases
import StoreKit
import Amplitude
import GoogleMobileAds

class SubscriptionPlansViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var blackWhiteGradient: UIView!
    @IBOutlet weak var firstOfferView: UIView!
    @IBOutlet weak var secondOfferView: UIView!
    @IBOutlet weak var thirdOfferView: UIView!
    
    @IBOutlet var dotViews: [UIView]!
    
    @IBOutlet var offerViews: [UIView]!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var trialPreriodLabel: UILabel!
    
    @IBOutlet var durationLabels: [UILabel]!
    @IBOutlet var priceLabels: [UILabel]!
    @IBOutlet var totalPriceLabels: [UILabel]!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var nextButton: BlueGradientButton!
    
    // Image Views
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var firstTick: UIImageView!
    @IBOutlet weak var secondTick: UIImageView!
    @IBOutlet weak var thirdTick: UIImageView!
    
    // Activity Indicators
    @IBOutlet var activityIndicators: [UIActivityIndicatorView]!
    // MARK: - Variables
    
    var didLayoutCalled = true
    
    var interstitial: GADInterstitialAd?
    var pageConfig: SubscriptionPlansPage = State.subscriptionPlansConfig
    
    var products: [StoreManager.Product] = []
    var selectedProductIndex: Int = 0
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
        createAndLoadInterstitialAd()
        localize()
        
        self.getProducts()
    }
    
    override func viewDidLayoutSubviews() {
        if didLayoutCalled {
            DispatchQueue.main.async {
                self.configureGradients()
                self.didLayoutCalled = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.addGradient(to: self.firstOfferView)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showCloseButton()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        titleLabel.text = pageConfig.titleLabel
        subtitleLabel.text = pageConfig.subtitleLabel
        closeButton.isHidden = true
        closeButton.tintColor = .black//UIColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 1)
        
        nextButton.setTitle(pageConfig.buttonLabel, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: pageConfig.buttonFontSize)
        
        privacyButton.isHidden = !pageConfig.showTerms
        termsButton.isHidden = !pageConfig.showTerms
        
        dotViews.forEach { dotView in
            dotView.isHidden = !pageConfig.showTerms
        }
        
        animateBackgound()
    }
    
    private func localize() {
        self.restoreButton.localize(with: L10n.Subscription.Button.restore)
        self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
        self.termsButton.localize(with: L10n.Subscription.Button.terms)
    }
    
    private func animateBackgound() {
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.contentsScale))
        pulseAnimation.duration = 0.8
        pulseAnimation.toValue = 3.2
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        mainImageView.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
    func configureGestures() {
        let firstOfferTapped = UITapGestureRecognizer(target: self, action: #selector(choosedFirst))
        let secondOfferTapped = UITapGestureRecognizer(target: self, action: #selector(choosedSecond))
        let thirdOfferTapped = UITapGestureRecognizer(target: self, action: #selector(choosedThird))
        firstOfferView.isUserInteractionEnabled = true
        secondOfferView.isUserInteractionEnabled = true
        thirdOfferView.isUserInteractionEnabled = true
        firstOfferView.addGestureRecognizer(firstOfferTapped)
        secondOfferView.addGestureRecognizer(secondOfferTapped)
        thirdOfferView.addGestureRecognizer(thirdOfferTapped)
    }
    
    func configureGradients() {
        blackWhiteGradient.applyGradient(colors: [
            CGColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 0.88),
            CGColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 0)
        ], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        // MARK: - Gradient for subscription border
        firstOfferView.layer.cornerRadius = 11
        secondOfferView.layer.cornerRadius = 11
        thirdOfferView.layer.cornerRadius = 11
        firstOfferView.clipsToBounds = true
        secondOfferView.clipsToBounds = true
        thirdOfferView.clipsToBounds = true
    }
    
    func addGradient(to gradientView: UIView) {
        // Add gradient layer
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: gradientView.frame.size)
        gradient.colors = [
            CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
            CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1)
        ]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: gradientView.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.path = UIBezierPath(roundedRect: gradientView.bounds, cornerRadius: gradientView.layer.cornerRadius).cgPath
        gradient.mask = shape
        gradientView.layer.addSublayer(gradient)
    }
    
    func removeGradient(from gradientView: UIView) {
        // Remove gradient layer
        if gradientView.layer.sublayers != nil {
            for layer in gradientView.layer.sublayers! {
                if type(of: layer) == CAGradientLayer.self {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    private func showCloseButton() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + pageConfig.closeDelay) {
            self.closeButton.isHidden = false
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
            showNetworkConnectionAlert(completion: nil)
            return
        }
        
        trialPreriodLabel.isHidden = true
        nextButton.isEnabled = false
        restoreButton.isEnabled = false
        
        for i in 0 ..< self.durationLabels.count {
            
            durationLabels[i].isHidden = true
            priceLabels[i].isHidden = true
            totalPriceLabels[i].isHidden = true
            
        }
        
//        let ids = ["com.temporary.month", "com.temporary.week", "com.temporary.year"] // DEBUG
        let ids = [pageConfig.firstSubscriptionId, pageConfig.secondSubscriptionId, pageConfig.thirdSubscriptionId] // RELEASE
        
        StoreManager.getProducts(for: ids) { products in
            guard !products.isEmpty else {
                self.dismiss(animated: true)
                return
            }
            self.products = products
            self.updateSubscriptionsUI()
        }

        
    }

    
    private func updateSubscriptionsUI() {
        
        offerViews.forEach { offerView in
            offerView.isHidden = true
        }
        
        nextButton.isEnabled = true
        restoreButton.isEnabled = true
        
        for i in 0 ..< self.products.count {
            
            activityIndicators[i].stopAnimating()
            durationLabels[i].isHidden = false
            durationLabels[i].text = products[i].skProduct.getSubscriptionPeriod(showOne: true)
            priceLabels[i].isHidden = false
            priceLabels[i].text = "\(products[i].price) \(products[i].subscriptionPeriod)"
            totalPriceLabels[i].isHidden = false
            totalPriceLabels[i].text = "\(L10n.Subscription.total): \(products[i].price)"
            offerViews[i].isHidden = false
            
            if let trialPeriod = self.products[i].trialPeriod {
                trialPreriodLabel.isHidden = false
                trialPreriodLabel.text = pageConfig.trialPeriodLabel
                    .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
                    .lowercased()
            }
            
            
        }
        
    }
    
    // MARK: - Gesture actions
    
    @objc func choosedFirst() {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        addGradient(to: firstOfferView)
        firstTick.isHidden = false
        secondTick.isHidden = true
        thirdTick.isHidden = true
        removeGradient(from: secondOfferView)
        removeGradient(from: thirdOfferView)
        selectedProductIndex = 0
    }
    
    @objc func choosedSecond() {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        addGradient(to: secondOfferView)
        firstTick.isHidden = true
        secondTick.isHidden = false
        thirdTick.isHidden = true
        removeGradient(from: firstOfferView)
        removeGradient(from: thirdOfferView)
        selectedProductIndex = 1
    }
    
    @objc func choosedThird() {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        addGradient(to: thirdOfferView)
        firstTick.isHidden = true
        secondTick.isHidden = true
        thirdTick.isHidden = false
        removeGradient(from: firstOfferView)
        removeGradient(from: secondOfferView)
        selectedProductIndex = 2
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
//        self.dismiss(animated: true)
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        Amplitude.instance().logEvent(AmplitudeEvents.paywallClose)
        showInterstitialAd()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {

        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        let package = self.products[selectedProductIndex].purchasesPackage
        
        Amplitude.instance().logEvent(AmplitudeEvents.subscriptionButtonTap)
        
        StoreManager.purchase(package: package) {
            self.dismiss(animated: true)
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

// MARK: - GADFullScreenContentDelegate

extension SubscriptionPlansViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will dismiss full screen content.")
        self.dismiss(animated: false)
        self.dismiss(animated: true)
    }
    
}
