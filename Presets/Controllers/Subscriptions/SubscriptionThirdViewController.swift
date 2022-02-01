import UIKit
import Amplitude

class SubscriptionThirdViewController: BaseSubscriptionViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var bottomGradientView: UIView!
    @IBOutlet var stackViewViews: [UIView]!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var featuresLabels: [UILabel]!
    
    // Buttons
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // Stack Views
    @IBOutlet weak var bottomButtonsStackView: UIStackView!
    
    // Activity Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    let pageConfig: ThirdSubscriptionPage = State.thirdSubscriptionPage
    
    var product: StoreManager.Product?
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showCloseButton()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.restoreButton.localize(with: L10n.Subscription.Button.restore)
        self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
        self.termsButton.localize(with: L10n.Subscription.Button.terms)
        
        titleLabel.localize(with: pageConfig.titleLabel)
        subtitleLabel.localize(with: pageConfig.subtitleLabel)
        subscribeButton.localize(with: pageConfig.subscribeButtonLabel)
        
        featuresLabels[0].text = pageConfig.features[0]
        featuresLabels[1].text = pageConfig.features[1]
        featuresLabels[2].text = pageConfig.features[2]
    }
    
    private func configureUI() {
        
        bottomGradientView.clipsToBounds = true
        bottomGradientView.applyGradient( colors: [
            CGColor(srgbRed: 0.031, green: 0.047, blue: 0.133, alpha: 0),
            CGColor(srgbRed: 0.031, green: 0.047, blue: 0.133, alpha: 1)
        ], startPoint: CGPoint(x: 0.5, y: 0.2), endPoint: CGPoint(x: 0.5, y: 0.6))
        
        for view in stackViewViews {
            view.clipsToBounds = true
            view.layer.cornerRadius = 30
        }
        
        self.closeButton.hide()
        self.bottomButtonsStackView.hide(!pageConfig.showTerms)
    }
    
    private func showCloseButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(pageConfig.closeDelay)) {
            self.closeButton.show()
        }
    }
    
    private func getProducts() {
        
        guard isConnectedToNetwork() else {
            showNetworkConnectionAlert {
                self.close()
            }
             return
        }
        
        priceLabel.hide()
        subscribeButton.isEnabled = false
        restoreButton.isEnabled = false
        
        let debugProductId = "com.temporary.week" // DEBUG
        let releaseProductId = pageConfig.subscriptionId // RELEASE
        
        let productId = DEBUG_MODE ? debugProductId : releaseProductId
        
        StoreManager.getProducts(for: [productId]) { products in
            
            guard let product = products.first else {
                self.close()
                return
            }
            
            self.product = product
            
            DispatchQueue.main.async {
                self.updateSubscriptionsUI()
            }
            
        }
           
    }
    
    private func updateSubscriptionsUI() {
        
        guard let product = product else {
            self.close()
            return
        }
        
        if let trialPeriod = product.trialPeriod {
            
            priceLabel.text = pageConfig.priceLabel
                .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
                .replacingOccurrences(of: "%subscription_price%", with: product.price)
                .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
                .lowercased()
            
        } else {
            
            priceLabel.text = pageConfig.priceLabel
                .replacingOccurrences(of: "%trial_period%", with: "No")
                .replacingOccurrences(of: "%subscription_price%", with: product.price)
                .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
                .lowercased()
            
        }
        
        activityIndicator.stopAnimating()
        priceLabel.show()
        subscribeButton.isEnabled = true
        restoreButton.isEnabled = true
        
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
        
        guard let product = product else { return }

        Amplitude.instance().logEvent(AmplitudeEvents.subscriptionButtonTap)
        
        StoreManager.purchase(package: product.purchasesPackage) {
            self.close()
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
            self.close()
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
