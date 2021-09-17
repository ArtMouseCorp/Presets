import UIKit
import SwiftyStoreKit
import StoreKit

class SubscriptionPlansViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var blackWhiteGradient: UIView!
    @IBOutlet weak var firstOfferView: UIView!
    @IBOutlet weak var secondOfferView: UIView!
    @IBOutlet weak var thirdOfferView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var nextButton: BlueGradientButton!
    
    // ImageViews
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var firstTick: UIImageView!
    @IBOutlet weak var secondTick: UIImageView!
    @IBOutlet weak var thirdTick: UIImageView!
    
    // MARK: - Variables
    
    var didLayoutCalled = true
    
    var closeTimer: Timer = Timer()
    var pageConfig: SubscriptionPlansPage = .default
    var products: [SKProduct] = []
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
        
        self.pageConfig = RCValues.sharedInstance.subscriptionPlansPage()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        startCloseTimer()
    }
    
    // MARK: - Custom functions
    
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
    
    private func getProducts() {
        
        // TODO: - Replace ID with purchase ID from pageConfig
        
                let subscriptionIds = Set<String>([
                    pageConfig.firstSubscriptionId,
                    pageConfig.secondSubscriptionId,
                    pageConfig.thirdSubscriptionId
                ])
        
//        let subscriptionIds = Set<String>([ "com.temporary.week", "com.temporary.month", "com.temporary.year" ])
        
        SwiftyStoreKit.retrieveProductsInfo(subscriptionIds) { result in
            
            for product in result.retrievedProducts {
                
                guard subscriptionIds.contains(product.productIdentifier) else { continue }
                
                self.products.append(product)
                print(self.products)
                
            }
            
            self.updateSubscriptionsUI()
            
        }
        
    }
    
    private func updateSubscriptionsUI() {
        
        
        
    }
    
    // MARK: - Gesture actions
    
    @objc func choosedFirst() {
        addGradient(to: firstOfferView)
        firstTick.isHidden = false
        secondTick.isHidden = true
        thirdTick.isHidden = true
        removeGradient(from: secondOfferView)
        removeGradient(from: thirdOfferView)
    }
    
    @objc func choosedSecond() {
        addGradient(to: secondOfferView)
        firstTick.isHidden = true
        secondTick.isHidden = false
        thirdTick.isHidden = true
        removeGradient(from: firstOfferView)
        removeGradient(from: thirdOfferView)
    }
    
    @objc func choosedThird() {
        addGradient(to: thirdOfferView)
        firstTick.isHidden = true
        secondTick.isHidden = true
        thirdTick.isHidden = false
        removeGradient(from: firstOfferView)
        removeGradient(from: secondOfferView)
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
//        let popup = PurchaseFailedViewController.load(from: .purchaseFailed)
//        popup.completion = {
//            self.view.removeFromSuperview()
//        }
//        self.showPopup(popup)
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                
                State.isSubscribed = false
                let purchaseFailedVC = PurchaseFailedViewController.load(from: .purchaseFailed)
                purchaseFailedVC.modalPresentationStyle = .fullScreen
                self.present(purchaseFailedVC, animated: true)
                
            } else if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoredPurchases)")
                
                State.isSubscribed = true
                self.showRestoredAlert {
                    let mainNav = UINavigationController.load(from: .mainNav)
                    mainNav.modalPresentationStyle = .fullScreen
                    self.present(mainNav, animated: true)
                }
                
            } else {
                print("Nothing to Restore")
                
                State.isSubscribed = false
                self.showNotSubscriberAlert(completion: nil)
                
            }
        }
        
    }
    
    @IBAction func privacyButtonPressed(_ sender: Any) {
        //        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        //        popup.titleLabelText = L10n.Privacy.title
        //        popup.mainText = FullPrivacyPolicy
        //        self.showPopup(popup)
        guard let url = URL(string: "https://artpoldev.com/privacy.html") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        //        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        //        popup.titleLabelText = L10n.ServiceTerms.title
        //        popup.mainText = FullTermsOfUse
        //        self.showPopup(popup)
        guard let url = URL(string: "https://artpoldev.com/terms.html") else { return }
        UIApplication.shared.open(url)
    }
    
}
