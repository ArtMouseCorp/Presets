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
    
    var completion: (() -> ())!
    
    // MARK: Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presetImage.layer.cornerRadius = 8
        presetButton.layer.cornerRadius = 8
    }

    override func prepareForReuse() {
        self.presetImage.image = UIImage()
        self.activityIndicator.startAnimating()
    }
    
    // MARK: - @IBActions
    
    @IBAction func presetButtonPressed(_ sender: Any) {
        completion()
    }
}
