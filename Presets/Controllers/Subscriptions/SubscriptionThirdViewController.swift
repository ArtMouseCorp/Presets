import UIKit

class SubscriptionThirdViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var bottomGradientView: UIView!
    @IBOutlet var stackViewViews: [UIView]!
    // Labels
    
    // Buttons
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    // Image Views
    // ...
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.restoreButton.localize(with: L10n.Subscription.Button.restore)
        self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
        self.termsButton.localize(with: L10n.Subscription.Button.terms)
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
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        // Close
        
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {

        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
//        let package = self.products[selectedProductIndex].purchasesPackage
        
//        Amplitude.instance().logEvent(AmplitudeEvents.subscriptionButtonTap)
        
//        StoreManager.purchase(package: package) {
//            self.dismiss(animated: true)
//        }
        
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
