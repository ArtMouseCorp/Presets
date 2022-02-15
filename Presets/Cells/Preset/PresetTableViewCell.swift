import UIKit

class PresetTableViewCell: UITableViewCell {
    
    // MARK: @IBoutlets
    
    // UIImages
    @IBOutlet weak var presetImage: UIImageView!
    
    // UIButtons
    @IBOutlet weak var presetButton: UIButton!
    
    // Activity Indicators
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Variables
    
    internal enum ButtonType {
        case delete, label
    }
    
    public var onButtonPress: (() -> ())? = nil
    
    let ALL = L10n.Main.allPresets
    let FREE = L10n.Main.freePresets
    let PREMIUM = L10n.Main.premiumPresets
    
    // MARK: Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presetImage.layer.cornerRadius = 8
        presetButton.layer.cornerRadius = 8
    }
    
    // MARK: - Custom functions
    
    public func configure(with preset: Preset, button: ButtonType) {
        
        switch button {
        case .delete:
            
            self.presetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            self.presetButton.setImage(Images.Icons.trash, for: .normal)
            self.presetButton.backgroundColor = UIColor(red: 249/255, green: 48/255, blue: 48/255, alpha: 1)
            self.presetButton.layer.cornerRadius = 22
            
            self.presetButton.isUserInteractionEnabled = true
            
        case .label:
            
            if State.isSubscribed {
                self.presetButton.isUserInteractionEnabled = false
                self.presetButton.isHidden = true
            } else {
                self.presetButton.setTitle(preset.isFree ? FREE : PREMIUM, for: .normal)
                self.presetButton.backgroundColor = preset.isFree ? UIColor(red: 1, green: 71/255, blue: 181/255, alpha: 1) : UIColor(red: 1, green: 71/255, blue: 71/255, alpha: 1)
                self.presetButton.isUserInteractionEnabled = false
            }
            
        }
        
        
        self.activityIndicator.stopAnimating()
        self.presetButton.isHidden = false
        self.presetImage.image = preset.getPreviewImage()
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func presetButtonPressed(_ sender: Any) {
        self.onButtonPress?() ?? ()
    }
}
