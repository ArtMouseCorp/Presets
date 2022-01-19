import UIKit
import Amplitude

 class SaleOfferViewController: BaseViewController {

     // MARK: - @IBOutlets
     
     // Views
     @IBOutlet weak var whiteOfferView: UIView!

     // Labels
     @IBOutlet weak var titleLabel: UILabel!
     @IBOutlet weak var saleLabel: UILabel!
     @IBOutlet weak var warningLimitLabel: UILabel!
     @IBOutlet weak var timeLabel: UILabel!
     @IBOutlet weak var offerLabel: UILabel!
     @IBOutlet weak var timeLeftLabel: UILabel!

     // Buttons
     @IBOutlet weak var nextButton: BlueGradientButton!
     @IBOutlet weak var restoreButton: UIButton!
     @IBOutlet weak var privacyButton: UIButton!
     @IBOutlet weak var termsButton: UIButton!

     // Activity indicators
     @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

     // MARK: - Variables
     
     let saleOfferStartDate: Date = State.getStartSaleOfferDate()
     var saleOfferEndDate: Date = Date()
     var saleOfferSecondsLeft: Int = 0
     
     let SALE_DURATION: Int = State.saleSubscriptionPage.saleDurationSeconds
     
     var timer = Timer()
     
     var timeLabelText: String = ""
     
     var product: StoreManager.Product?

     var onClose: ((String) -> ())? = nil

     // MARK: - Awake functions
     
     override func viewDidLoad() {
         super.viewDidLoad()
         self.getProducts()
         self.timeLabel.text = timeLabelText
         localize()
     }

     override func viewWillAppear(_ animated: Bool) {
         configureUI()
         calculateSaleOfferEndDate()
     }

     override func viewWillDisappear(_ animated: Bool) {
         timer.invalidate()
     }

     // MARK: - Custom functions
     
     private func localize() {
         self.titleLabel.localize(with: State.saleSubscriptionPage.titleLabel)
         self.saleLabel.localize(with: State.saleSubscriptionPage.saleLabel)
         self.warningLimitLabel.localize(with: State.saleSubscriptionPage.limitedWarningLabel)
         self.timeLeftLabel.localize(with: State.saleSubscriptionPage.timeLeftLabel)
         self.nextButton.localize(with: State.saleSubscriptionPage.subscriptionButtonLabel)
         
         self.restoreButton.localize(with: L10n.Subscription.Button.restore)
         self.privacyButton.localize(with: L10n.Subscription.Button.privacy)
         self.termsButton.localize(with: L10n.Subscription.Button.terms)
     }

     private func configureUI() {
         nextButton.titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: 19)
         whiteOfferView.layer.cornerRadius = 13
         activityIndicator.hidesWhenStopped = true
     }
     
     private func calculateSaleOfferEndDate() {
         saleOfferEndDate = saleOfferStartDate.addingTimeInterval(TimeInterval(SALE_DURATION))
         saleOfferSecondsLeft = Int(saleOfferEndDate.timeIntervalSince(Date()))
         
         if saleOfferSecondsLeft <= 0 {
             self.dismiss(animated: true)
             return
         }
         
         timerStart()
     }

     private func timerStart() {
         self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setLabelText), userInfo: nil, repeats: true)
     }

     @objc private func setLabelText() {
         DispatchQueue.main.async {
             
             self.saleOfferSecondsLeft = Int(self.saleOfferEndDate.timeIntervalSince(Date()))
             
             guard self.saleOfferSecondsLeft > 0 else {
                 self.timer.invalidate()
                 self.dismiss(animated: true)
                 return
             }
             
             let hours = Int(self.saleOfferSecondsLeft / 3600)
             let minutes = Int((self.saleOfferSecondsLeft - hours * 3600) / 60)
             let seconds = Int((self.saleOfferSecondsLeft - hours * 3600) % 60)
             
             self.timeLabelText = "\(hours):\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
             self.timeLabel.text = self.timeLabelText
         }
     }
     
     private func getProducts() {
         
         guard isConnectedToNetwork() else {
             showNetworkConnectionAlert(completion: nil)
             return
         }
         
         titleLabel.isHidden = true
         whiteOfferView.isHidden = true
         saleLabel.isHidden = true
         warningLimitLabel.isHidden = true
         offerLabel.isHidden = true
         nextButton.isEnabled = false
         restoreButton.isEnabled = false
         
         activityIndicator.startAnimating()

         let id = ["com.temporary.week"] // DEBUG
//         let id = [State.saleSubscriptionPage.subscriptionId] // RELEASE
         
         StoreManager.getProducts(for: id) { products in
             
             guard let product = products.first else {
                 self.dismiss(animated: true)
                 return
             }
             
             self.product = product
             self.updateSubscriptionsUI()
         }
         
     }
     
     private func updateSubscriptionsUI() {
         
         guard let product = product else {
             self.dismiss(animated: true)
             return
         }
         
//         let oldAttributedPrice = NSMutableAttributedString(
//            string: State.saleSubscriptionPage.oldPrice,
//            attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
//         )
         
         offerLabel.text = State.saleSubscriptionPage.priceLabel
             .replacingOccurrences(of: "%subscription_price%", with: product.price)
             .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
         
         offerLabel.strikethrough(from: "%", to: "%")
         
         titleLabel.localize(with: State.saleSubscriptionPage.titleLabel)
         saleLabel.localize(with: State.saleSubscriptionPage.saleLabel)
         warningLimitLabel.localize(with: State.saleSubscriptionPage.limitedWarningLabel)
         nextButton.localize(with: State.saleSubscriptionPage.subscriptionButtonLabel)
         
         activityIndicator.stopAnimating()
         
         titleLabel.isHidden = false
         saleLabel.isHidden = false
         whiteOfferView.isHidden = false
         warningLimitLabel.isHidden = false
         offerLabel.isHidden = false
         nextButton.isEnabled = true
         restoreButton.isEnabled = true
         
     }

     // MARK: - @IBActions
     
     @IBAction func closeButtonPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
         self.onClose?(timeLabelText) ?? ()
     }

     @IBAction func nextButtonPressed(_ sender: Any) {
         
         let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
         selectionFeedbackGenerator.selectionChanged()
         
         guard isConnectedToNetwork() else {
             self.showNetworkConnectionAlert()
             return
         }
         
         guard let product = product else {
             return
         }
         
         Amplitude.instance().logEvent(AmplitudeEvents.subscriptionButtonTap)
         
         StoreManager.purchase(package: product.purchasesPackage) {
             self.dismiss(animated: true)
         }
         
         
     }

     @IBAction func restoreButtonPressed(_ sender: Any) {

         let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
         selectionFeedbackGenerator.selectionChanged()

         guard isConnectedToNetwork() else {
             showNetworkConnectionAlert(completion: nil)
             return
         }

         guard !State.isSubscribed else {
             showAlreadySubscribedAlert(completion: nil)
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
