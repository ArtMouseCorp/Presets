import UIKit
import Amplitude

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
        locelize()
        overlayImage.frame = CGRect(x: 0, y: 0, width: screen_width, height:screen_height)
        self.view.insertSubview(overlayImage, at: 0)
        introduceTitle.numberOfLines = 0
        setPageContent()
    }
    
    // MARK: - Custom functions
    
    private func locelize() {
        self.nextButton.localize(with: L10n.Subscription.Button.next)
    }
    
    func setPageContent() {
        
        switch currentIntroducePage {
        case 0:
            overlayImage.image = Images.circleBackground1
            mainImage.image = Images.onboardingImage1
            introduceTitle.localize(with: L10n.Onboarding.Title.first)
            introduceSubtitle.localize(with: L10n.Onboarding.Subtitle.first)
        case 1:
            overlayImage.image = Images.circleBackground2
            mainImage.image = Images.onboardingImage2
            introduceTitle.localize(with: L10n.Onboarding.Title.second)
            introduceSubtitle.localize(with: L10n.Onboarding.Subtitle.second)
            animateIn()
        case 2:
            RCValues.sharedInstance.currentPaywall()
            imageTopConstraint.constant = 0
            imageLeftConstraint.constant = 0
            imageRightConstraint.constant = 0
            mainImage.image = Images.onboardingImage3
            mainImage.contentMode = .bottom
            introduceTitle.localize(with: L10n.Onboarding.Title.third)
            introduceSubtitle.localize(with: L10n.Onboarding.Subtitle.third)
            animateIn()
        default:
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
            return
        }
        
        Amplitude.instance().logEvent(
            AmplitudeEvents.onboarding,
            withEventProperties: [ "Onboarding page number": currentIntroducePage ]
        )
        
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
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        currentIntroducePage += 1
        setPageContent()
    }
}
