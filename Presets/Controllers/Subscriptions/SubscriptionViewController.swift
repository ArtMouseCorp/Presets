import UIKit

class SubscriptionViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var blackWhiteGradient: UIView!
    @IBOutlet weak var firstOfferView: UIView!
    @IBOutlet weak var secondOfferView: UIView!

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
        self.view.removeFromSuperview()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        // TODO: - Something next
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        // TODO: - Restore purchase
    }
    
    @IBAction func privacyButtonPressed(_ sender: Any) {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Privacy Policy"
        self.showPopup(popup)
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        let popup = SettingsPopupViewController.load(from: .settingsPopup)
        popup.titleLabelText = "Terms of Service"
        self.showPopup(popup)
    }
}
