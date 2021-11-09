import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var lineView: UIView!
    
    // Labels
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Custom functions
    
    public func configure(with category: String, selected: Bool) {
        
        self.categoryNameLabel.text = category
        
        self.categoryNameLabel.textColor = selected ? .white : UIColor(red: 97/255, green: 103/255, blue: 134/255, alpha: 1)
        self.lineView.isHidden = !selected
        
    }
    
}
