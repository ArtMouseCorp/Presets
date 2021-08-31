import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var introduceTitle: UILabel!
    @IBOutlet weak var introduceSubtitle: UILabel!

    // Buttons
    @IBOutlet weak var nextButton: BlueGradientButton!

    // ImageViews
    @IBOutlet weak var mainImage: UIImageView!
    
    // StackViews
    @IBOutlet weak var dotsStackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var imageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var currentIntroducePage = 0
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    var overlayImage = UIImageView()
    let mainVC = UINavigationController.load(from: .mainNav)
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayImage.frame = CGRect(x: 0, y: 0, width: screen_width, height:screen_height)
        self.view.insertSubview(overlayImage, at: 0)
        setPageContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setPageContent()
    }
    
    // MARK: - Custom functions
    
    func setPageContent() {
        switch currentIntroducePage {
        case 0:
            overlayImage.image = Images.circleBackground1
            mainImage.image = Images.onboardingImage1
            introduceSubtitle.text = "Import presets into Lightroom"
            animateIn()
        case 1:
            overlayImage.image = Images.circleBackground2
            mainImage.image = Images.onboardingImage2
            introduceTitle.text = "Select a style and apply it"
            introduceSubtitle.text = "Style your work"
            animateIn()
        case 2:
            imageTopConstraint.constant = 0
            imageLeftConstraint.constant = 0
            imageRightConstraint.constant = 0
            mainImage.image = Images.onboardingImage3
            mainImage.contentMode = .bottom
            introduceTitle.text = "Enjoy +100 presets Lightroom"
            introduceSubtitle.text = "Beginner friendly"
            animateIn()
        default:
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
        }
        configureDots()
    }
    
    func animateIn() {
        // Animate image
//        self.mainImage.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
//            self.mainImage.transform = .identity
//        }
        
        // Animate text
        self.mainImage.alpha = 0.0
        self.introduceTitle.alpha = 0.0
        self.introduceSubtitle.alpha = 0.0
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            self.introduceTitle.alpha = 1
            self.introduceSubtitle.alpha = 1
            self.mainImage.alpha = 1
        })
        
    }
    
    func configureDots() {
        var currentDot = 0
        for dot in dotsStackView.subviews {
            dot.backgroundColor = currentDot == currentIntroducePage ? UIColor(patternImage: Images.Icons.choosen!) : UIColor(patternImage: Images.Icons.notChoosen!)
            currentDot += 1
        }
    }

    // MARK: - @IBActions
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentIntroducePage += 1
        setPageContent()
    }
}
