import UIKit

class PresetCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Constraints
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    let ALL = L10n.Main.allPresets
    let FREE = L10n.Main.freePresets
    let PREMIUM = L10n.Main.premiumPresets
    
    var currentCategoryID: Int = 0
    var countOfRowsInTableView = 0
    var items: [String] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(.preset)
    }
    
    override func prepareForReuse() {
        tableView.isHidden = true
    }
}

extension PresetCategoryCollectionViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countOfRowsInTableView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        
        var currentPreset = Preset.all[0]
        
        if currentCategoryID == 0 {
            currentPreset = Preset.all[indexPath.row]
        } else if items[currentCategoryID] == FREE {
            currentPreset = Preset.free[indexPath.row]
        } else if items[currentCategoryID] == PREMIUM {
            currentPreset = Preset.premium[indexPath.row]
        } else {
            Preset.all.forEach { preset in
                if preset.name == items[currentCategoryID] {
                    currentPreset = preset
                }
            }
        }
        
        cell.presetImage.load(from: currentPreset.titleImageURL) {
            cell.activityIndicator.stopAnimating()
        }

        if currentPreset.isFree {
            cell.presetButton.setTitle(FREE, for: .normal)
            cell.presetButton.backgroundColor = UIColor(red: 1, green: 71/255, blue: 181/255, alpha: 1)
        } else {
            cell.presetButton.setTitle(PREMIUM, for: .normal)
            cell.presetButton.backgroundColor = UIColor(red: 1, green: 71/255, blue: 71/255, alpha: 1)
        }
        
        cell.presetButton.isUserInteractionEnabled = false
        cell.completion = {}
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if currentCategoryID == 0 {
            State.selectedPreset = Preset.all[indexPath.row]
        } else if items[currentCategoryID] == FREE {
            State.selectedPreset = Preset.free[indexPath.row]
        } else if items[currentCategoryID] == PREMIUM {
            State.selectedPreset = Preset.premium[indexPath.row]
        } else {
            Preset.all.forEach { preset in
                if preset.name == items[currentCategoryID] {
                    State.selectedPreset = preset
                }
            }
        }
        
        let presetVC = PresetViewController.load(from: .preset)
        presetVC.presetId = State.selectedPreset.id
        navigationController.pushViewController(presetVC, animated: true)
    
}
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
