import UIKit

class PresetTableViewCell: UITableViewCell {
    
    // MARK: @IBoutlets
    
    // UIImages
    @IBOutlet weak var presetImage: UIImageView!
    
    // UIButtons
    @IBOutlet weak var presetButton: UIButton!
    
    // MARK: Variables
    
    var completion: (() -> ())!
    
    // MARK: Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presetImage.layer.cornerRadius = 8
        presetButton.layer.cornerRadius = 8
    }
    
    // MARK: - @IBActions
    @IBAction func presetButtonPressed(_ sender: Any) {
        completion()
    }
}
