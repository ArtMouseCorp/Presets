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
            
            titleLabel.localize(with: L10n.Delete.title)
            confirmButton.localize(with: L10n.Delete.Button.confirm)
            cancelButton.localize(with: L10n.Delete.Button.cancel)
            cancelButton.setImage(nil, for: .normal)
            
        case .openPresetPopup:
            confirmButton.initialize(as: .blueGradientButton)
            
            titleLabel.localize(with: L10n.OpenPreset.title)
            confirmButton.localize(with: L10n.OpenPreset.Button.open)
            cancelButton.localize(with: L10n.OpenPreset.Button.openManual)
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
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        switch mode {
        case .deletePresetPopup:
            animateOut()
        case .openPresetPopup:
            let manualVC = ManualViewController.load(from: .manual)
            self.navigationController?.pushViewController(manualVC, animated: true)
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        switch mode {
        case .deletePresetPopup:
            State.favouritePresets.remove(at: deleteIndex)
            userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
            animateOut()
            completion()
        case .openPresetPopup:
            
            guard State.isSubscribed || State.selectedPreset.isFree else {
                self.showPaywall()
                return
            }
            
            State.selectedPreset.getDNGData(for: indexOfImagePreset) { data in
                
                let activityController = UIActivityViewController(activityItems: [data] as [Any], applicationActivities: nil)
                
                self.hideLoader() {
                    self.present(activityController, animated: true)
                }
                
            }
            
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        animateOut()
    }
    
}
