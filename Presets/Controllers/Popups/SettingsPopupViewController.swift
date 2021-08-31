import UIKit

class SettingsPopupViewController: PopupViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var backgroundView: PopupBackgroundView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Variables
    
    var titleLabelText = ""
    var mainText = ""
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        titleLabel.text = titleLabelText
        textView.text = mainText
        animateIn()
    }
    
    // MARK: - Custom functions
    
    func configureTextView() {
        textView.setLineHeight(lineHeight: 10)
        textView.font = UIFont(name: "EuclidCircularA-Regular", size: 15)
        textView.textColor = UIColor.white
    }
    
    // MARK: - Animation
    
    func animateIn() {
        backgroundView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.backgroundView.transform = .identity
        }
    }
    
    func animateOut() {
        self.view.alpha = 1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.view.alpha = 0
            self.backgroundView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        } completion: { completed in
            self.view.removeFromSuperview()
        }
    }
    
    // MARK: - Override
    
    override func backgroundTapped() {
        animateOut()
    }
    
    // MARK: - @IBActions

    @IBAction func closeButtonPressed(_ sender: Any) {
        animateOut()
    }
}
