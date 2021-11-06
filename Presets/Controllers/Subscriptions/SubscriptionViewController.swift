import UIKit
import GoogleMobileAds
import Amplitude
import StoreKit
import Purchases
import AVFoundation

class SubscriptionViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var blackWhiteGradient: UIView!
    @IBOutlet weak var firstOfferView: UIView!
    @IBOutlet weak var secondOfferView: UIView!
    @IBOutlet var dotViews: [UIView]!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var subscriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var nextButton: BlueGradientButton!
    
    // ImageViews
    @IBOutlet weak var mainImageView: UIImageView!
    
    // MARK: - Variables
    
    var didLayoutCalled = true
    
    var interstitial: GADInterstitialAd?
    var pageConfig: OrganicSubscriptionPage = .default
    
    var closeTimer: Timer = Timer()
    
    var package: Purchases.Package = Purchases.Package()
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        
        createAndLoadInterstitialAd()
        configureGestures()
        firstOfferView.isHidden = true
        
        self.pageConfig = RCValues.sharedInstance.organicSubscriptionPage()
        
        getProduct()
        
    }
    
    override func viewDidLayoutSubviews() {
        if didLayoutCalled {
            DispatchQueue.main.async {
                self.configureGradients()
                self.didLayoutCalled = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.addGradient(to: self.secondOfferView)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startCloseTimer()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        titleLabel.text = pageConfig.titleLabel
        subtitleLabel.text = pageConfig.subtitleLabel
        closeButton.isHidden = true
        
        nextButton.setTitle(pageConfig.buttonLabel, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: pageConfig.buttonFontSize)
        
        privacyButton.isHidden = !pageConfig.showTerms
        termsButton.isHidden = !pageConfig.showTerms
        
        dotViews.forEach { dotView in
            dotView.isHidden = !pageConfig.showTerms
        }
        
    }
    
    private func localize() {
        self.restoreButton.localize(with: L10n.Subscription.Button.restore)
        self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
        self.termsButton.localize(with: L10n.Subscription.Button.terms)
    }
    
    func configureGestures() {
        let firstOfferTapped = UITapGestureRecognizer(target: self, action: #selector(choosedFirst))
        let secondOfferTapped = UITapGestureRecognizer(target: self, action: #selector(choosedSecond))
        firstOfferView.isUserInteractionEnabled = true
        secondOfferView.isUserInteractionEnabled = true
        firstOfferView.addGestureRecognizer(firstOfferTapped)
        secondOfferView.addGestureRecognizer(secondOfferTapped)
    }
    
    func configureGradients() {
        blackWhiteGradient.applyGradient(colors: [
            CGColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 0.88),
            CGColor(red: 8/255, green: 12/255, blue: 34/255, alpha: 0)
        ], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        // MARK: - Gradient for subscription border
        firstOfferView.layer.cornerRadius = 11
        secondOfferView.layer.cornerRadius = 11
        firstOfferView.clipsToBounds = true
        secondOfferView.clipsToBounds = true
    }
    
    private func startCloseTimer() {
        
        closeTimer = Timer.scheduledTimer(timeInterval: pageConfig.closeDelay,
                                          target: self,
                                          selector: #selector(showCloseButton),
                                          userInfo: nil, repeats: true)
        
    }
    
    @objc private func showCloseButton() {
        closeButton.isHidden = false
        closeTimer.invalidate()
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
        
        // Show tick
        for view in gradientView.subviews {
            if type(of: view) == UIImageView.self {
                view.isHidden = false
            }
        }
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
        // Hide tick
        for view in gradientView.subviews {
            if type(of: view) == UIImageView.self {
                view.isHidden = true
            }
        }
    }
    
    private func getProduct() {
        
        guard isConnectedToNetwork() else {
            showNetworkConnectionAlert() {
                
            }
            return
        }
        
        let productId = DEBUG ? "com.temporary.week" : pageConfig.subscriptionId
        
        StoreManager.getProducts(for: [productId]) { products in
            
            let finalString = self.pageConfig.priceLabel
                .replacingOccurrences(of: "%trial_period%", with: products[0].trialPeriod ?? "")
                .replacingOccurrences(of: "%subscription_price%", with: products[0].price)
                .replacingOccurrences(of: "%subscription_period%", with: products[0].subscriptionPeriod)
            
            self.subscriptionLabel.text = finalString
            
            self.package = products[0].purchasesPackage
            
        }
        
    }
    
    // MARK: - Gesture actions
    
    @objc func choosedFirst() {
        addGradient(to: firstOfferView)
        removeGradient(from: secondOfferView)
    }
    
    @objc func choosedSecond() {
        addGradient(to: secondOfferView)
        removeGradient(from: firstOfferView)
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
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
        
        Amplitude.instance().logEvent(AmplitudeEvents.subscriptionButtonTap)
        
        StoreManager.purchase(package: self.package) {
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
            showAlreadySubscribedAlert() {
                self.view.removeFromSuperview()
            }
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

extension SubscriptionViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
        self.view.removeFromSuperview()
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will dismiss full screen content.")
    }
    
}
