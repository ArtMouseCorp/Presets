import UIKit
import Amplitude
import StoreKit
import Purchases
import AVFoundation

class SubscriptionViewController: BaseSubscriptionViewController {
    
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
    
    // Activity Indicators
    @IBOutlet weak var secondActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    var didLayoutCalled = true
    
    var pageConfig: OrganicSubscriptionPage = State.subscriptionConfig
    
    var closeTimer: Timer = Timer()
    
    var package: Purchases.Package = Purchases.Package()
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        configureGestures()
        firstOfferView.isHidden = true
        
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
    
//    private func createAndLoadInterstitialAd() {
//
//        let request = GADRequest()
//
//        GADInterstitialAd.load(withAdUnitID: Keys.AdmMod.unitId, request: request) { [self] ad, error in
//            if let error = error {
//                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                return
//            }
//            interstitial = ad
//            interstitial?.fullScreenContentDelegate = self
//        }
//
//    }
//
//    private func showInterstitialAd() {
//
//        guard let interstitial = interstitial else {
//            print("Ad wasn't ready")
//            self.view.removeFromSuperview()
//            return
//        }
//
//        interstitial.present(fromRootViewController: self)
//        Amplitude.instance().logEvent(AmplitudeEvents.afterSubscriptionAd)
//    }
    
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
            showNetworkConnectionAlert()
            return
        }
        
        nextButton.isEnabled = false
        restoreButton.isEnabled = false
        self.subscriptionLabel.isHidden = true
        
        let debugProductId = "com.temporary.week" // DEBUG
        let releaseProductId = pageConfig.subscriptionId // RELEASE
        
        let productId = DEBUG_MODE ? debugProductId : releaseProductId
        
        StoreManager.getProducts(for: [productId]) { products in
            
            guard let product = products.first else {
                self.view.removeFromSuperview()
                return
            }
            
            self.nextButton.isEnabled = true
            self.restoreButton.isEnabled = true
            
            let finalString = self.pageConfig.priceLabel
                .replacingOccurrences(of: "%trial_period%", with: product.trialPeriod ?? "")
                .replacingOccurrences(of: "%subscription_price%", with: product.price)
                .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
            
            self.subscriptionLabel.text = finalString
            self.subscriptionLabel.isHidden = false
            self.secondActivityIndicator.stopAnimating()
            
            self.package = product.purchasesPackage
            
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
        
        self.close()
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
