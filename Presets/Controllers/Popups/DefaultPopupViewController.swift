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
    
    var indexOfImagePreset = 0
    var deleteIndex = 0
    var completion: (()->())!
    enum Mode {
        case deletePresetPopup, openPresetPopup
    }
    var mode: Mode = .deletePresetPopup
    
    // MARK: - Awake Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        animateIn()
    }
    
    // MARK: - Custom Functions
    
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
    
    @IBAction func cancelButtonPressed() {
        switch mode {
        case .deletePresetPopup:
            animateOut()
        case .openPresetPopup:
            let manualVC = ManualViewController.load(from: .manual)
            self.navigationController?.pushViewController(manualVC, animated: true)
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        switch mode {
        case .deletePresetPopup:
            State.favouritePresets.remove(at: deleteIndex)
            userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
            animateOut()
            completion()
        case .openPresetPopup:
            guard let fileURL = Bundle.main.url(forResource: State.selectedPreset.presets[indexOfImagePreset] , withExtension: "dng") else {
                animateOut()
                return
            }
            var items: [Any] = []
            items.append(fileURL)
            let activityController = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
            present(activityController, animated: true)
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        animateOut()
    }
    
}
