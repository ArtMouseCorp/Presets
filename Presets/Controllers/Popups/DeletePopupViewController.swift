import UIKit

class DefaultPopupViewController: PopupViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var backgroundView: RoundedView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var confirmButton: GradientButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmButton.initialize(as: .blueGradientButton)
    }
    
    // MARK: - Custom functions
    
    // MARK: - @IBActions
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        // TODO: - Confirm action
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
