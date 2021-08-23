import UIKit

class ManualViewController: BaseViewController {
    
    // Views
    @IBOutlet weak var stepOneView: UIView!
    @IBOutlet weak var stepTwoView: UIView!
    @IBOutlet weak var stepThreeView: UIView!
    @IBOutlet weak var stepFourView: UIView!
    @IBOutlet weak var stepFiveView: UIView!
    @IBOutlet weak var stepSixView: UIView!

    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepOneLabel: UILabel!
    @IBOutlet weak var stepTwoLabel: UILabel!
    @IBOutlet weak var stepThreeLabel: UILabel!
    @IBOutlet weak var stepFourLabel: UILabel!
    @IBOutlet weak var stepFiveLabel: UILabel!
    @IBOutlet weak var stepSixLabel: UILabel!
    @IBOutlet weak var stepSixDescriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var watchVideoTutorialButton: BlueGradientButton!
    @IBOutlet weak var installLightroomView: UIView!
    
    // Constraints
    @IBOutlet weak var firstStepHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondStepHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdStepHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthStepHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fifthStepHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sixStepHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sixStepDescriptionHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    
    var didLayoutCalled = true
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientButton()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        if didLayoutCalled {
            DispatchQueue.main.async {
                self.setupLabels()
                self.didLayoutCalled = false
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.setupGradients()
            }
        }
    }
    
    // MARK: - Custom functions
    
    func setupLabels() {
        setupLabel(label: stepOneLabel, constraint: firstStepHeightConstraint)
        setupLabel(label: stepTwoLabel, constraint: secondStepHeightConstraint)
        setupLabel(label: stepThreeLabel, constraint: thirdStepHeightConstraint)
        setupLabel(label: stepFourLabel, constraint: fourthStepHeightConstraint)
        setupLabel(label: stepFiveLabel, constraint: fifthStepHeightConstraint)
        setupLabel(label: stepSixLabel, constraint: sixStepHeightConstraint)
        setupLabel(label: stepSixDescriptionLabel, constraint: sixStepDescriptionHeightConstraint)
    }
    
    func setupLabel(label: UILabel, constraint: NSLayoutConstraint) {
        label.setLineHeight(lineHeight: 8)
        label.sizeToFit()
        constraint.constant = label.frame.height
    }
    
    func setupGradients() {
        addGradientBorders(to: stepOneView)
        addGradientBorders(to: stepTwoView)
        addGradientBorders(to: stepThreeView)
        addGradientBorders(to: stepFourView)
        addGradientBorders(to: stepFiveView)
        addGradientBorders(to: stepSixView)
    }
    
    func addGradientBorders(to gradientView: UIView) {
        gradientView.layer.cornerRadius = 28
        gradientView.clipsToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: gradientView.frame.size)
        gradient.colors = [
            CGColor(red: 5/255, green: 9/255, blue: 28/255, alpha: 1),
            CGColor(red: 25/255, green: 34/255, blue: 77/255, alpha: 1)
        ]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(rect: gradientView.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.path = UIBezierPath(roundedRect: gradientView.bounds, cornerRadius: gradientView.layer.cornerRadius).cgPath
        gradient.mask = shape
        gradientView.layer.addSublayer(gradient)
    }
    
    func configureGradientButton() {
        installLightroomView.layer.cornerRadius = 11
        installLightroomView.clipsToBounds = true
        installLightroomView.layer.shadowColor = CGColor(red: 52/255, green: 77/255, blue: 215/255, alpha: 0.25)
        installLightroomView.applyGradient(colors: [
            CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
            CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1)
        ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: installLightroomView.bounds.insetBy(dx: 0, dy: -1 * installLightroomView.bounds.size.height))
    }
    
    func setupGestures() {
        let tapOnInstallLightroom = UITapGestureRecognizer(target: self, action: #selector(installLightroomTapped))
        installLightroomView.isUserInteractionEnabled = true
        installLightroomView.addGestureRecognizer(tapOnInstallLightroom)
    }
    
    // MARK: - Gesture actions
    
    @objc func installLightroomTapped() {
        if let url = URL(string: "itms-apps://apple.com/app/id878783582") {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func watchVideoButtonPressed(_ sender: Any) {
        // TODO: - Open video tutorial
    }
    
}
