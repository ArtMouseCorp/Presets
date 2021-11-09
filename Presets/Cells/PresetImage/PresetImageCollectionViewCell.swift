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
        
    // Activity Indicator Views
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Awake functions
    
    override func prepareForReuse() {
        self.imageView.image = UIImage()
        self.activityIndicator.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        openPresetLabel.localize(with: L10n.Preset.tapHint)
    }
    
    // MARK: - Custom function
    
    private func configureUI() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
    }
    
    public func configure(with imageURL: URL, isFirst: Bool) {
        
        if openPresetView != nil {
            self.openPresetView.isHidden = true            
        }
        
        self.imageView.load(from: imageURL) {
            self.activityIndicator.stopAnimating()
            
            if isFirst && self.openPresetView != nil {
                self.openPresetView.isHidden = false
            }
            
        }
        
    }
}
