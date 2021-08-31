import UIKit

class SubscriptionSecondViewController: BaseViewController {

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
    var closeButtonIsHidden = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
        closeButton.isHidden = closeButtonIsHidden
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
        self.view.removeFromSuperview()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let popup = PurchaseFailedViewController.load(from: .purchaseFailed)
        popup.completion = {
            self.view.removeFromSuperview()
        }
        self.showPopup(popup)
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        // TODO: - Restore purchase
    }
    
    @IBAction func privacyButtonPressed(_ sender: Any) {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Privacy Policy"
        popup.mainText = FullPrivacyPolicy
        self.showPopup(popup)
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Terms of Service"
        popup.mainText = FullTermsOfUse
        self.showPopup(popup)
    }
    
}
