import UIKit

class SettingsPopupViewController: PopupViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Variables
    
    var titleLabelText = ""
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        titleLabel.text = titleLabelText
    }
    
    // MARK: - Custom functions
    
    func configureTextView() {
        textView.setLineHeight(lineHeight: 10)
        textView.font = UIFont(name: "EuclidCircularA-Regular", size: 15)
        textView.textColor = UIColor.white
    }
    
    // MARK: - @IBActions

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
