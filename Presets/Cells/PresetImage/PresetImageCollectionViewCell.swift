import UIKit

class PresetImageCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var openPresetView: UIView!
    
    // ImageViews
    @IBOutlet weak var imageView: UIImageView!
    
    // Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        setupGestures()
    }
    
    func setupGestures() {
        let holdGesture = UILongPressGestureRecognizer(target: self, action: #selector(removeView))
        openPresetView.isUserInteractionEnabled = true
        openPresetView.addGestureRecognizer(holdGesture)
    }
    
    @objc func removeView(){
        openPresetView.removeFromSuperview()
    }
}
