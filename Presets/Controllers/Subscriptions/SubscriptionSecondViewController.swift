import UIKit

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
    @IBOutlet weak var continueButton: BlueGradientButton!
    
    // Image Views
    @IBOutlet weak var firstSubscriptionTickImage: UIImageView!
    @IBOutlet weak var secondSubscriptionTickImage: UIImageView!
    
    // MARK: - Variables
    
    let tickOnImage = UIImage(named: "tick-white")
    let tickOffImage = UIImage(named: "tick-empty")
    var isFirstSub = true
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.restoreButton.localize(with: L10n.Subscription.Button.restore)
        self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
        self.termsButton.localize(with: L10n.Subscription.Button.terms)
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
    }
    
    private func setupGestures() {
        firstSubscriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstSubscriptionViewTapped)))
        secondSubscriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondSubscriptionViewTapped)))
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
        
        if isFirstSub {
            // Sub first
        } else {
            // Sub second
        }
        
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
