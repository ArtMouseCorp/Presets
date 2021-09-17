import UIKit

class PresetImageCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var openPresetView: UIView!
    
    // Labels
    @IBOutlet weak var openPresetLabel: UILabel!
    
    // ImageViews
    @IBOutlet weak var imageView: UIImageView!
        
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        openPresetLabel.localize(with: L10n.Preset.tapHint)
    }
}
