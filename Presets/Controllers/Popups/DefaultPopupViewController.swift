import UIKit

class DefaultPopupViewController: PopupViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var backgroundView: PopupBackgroundView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var confirmButton: GradientButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Variables
    
    enum Mode {
        case deletePresetPopup, openPresetPopup
    }
    
    var mode: Mode = .deletePresetPopup
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Custom functions
    
    func initialize(as mode: Mode) {
        self.mode = mode
    }
    
    func initialize() {
        switch mode {
        case .deletePresetPopup:
            confirmButton.initialize(as: .redGradientButton)

            titleLabel.text = "Delete preset?"
            confirmButton.setTitle("Yes, delete", for: .normal)
            cancelButton.setTitle("No, cancel", for: .normal)
            cancelButton.setImage(nil, for: .normal)
            
            
        case .openPresetPopup:
            confirmButton.initialize(as: .blueGradientButton)

            titleLabel.text = "Do you know how to use presets?"
            confirmButton.setTitle("Yes, open a preset", for: .normal)
            cancelButton.setTitle("No, open the manual", for: .normal)
            cancelButton.setImage(Images.Icons.note, for: .normal)
            
        }
    }

    // MARK: - @IBActions
    
    @IBAction func cancelButtonPressed() {
        switch mode {
        case .deletePresetPopup:
            self.view.removeFromSuperview()
        case .openPresetPopup:
            let manualVC = ManualViewController.load(from: .manual)
            self.navigationController?.pushViewController(manualVC, animated: true)
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        switch mode {
        case .deletePresetPopup:
            () // TODO: - Delete choosed preset
        case .openPresetPopup:
            () // TODO: - Open choosed preset
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
