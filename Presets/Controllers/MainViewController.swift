import UIKit

class MainViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var userPresetsButton: UIButton!
    
    // MARK: - Variables
    
    var categories = ["All", "Free", "Premium", "Dark", "Summer"]
    var images = ["preset1", "preset2"]
    var presetIsFree = true
    var currentCategoryID = 0
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTableView()
        let popup = SubscriptionSecondViewController.load(from: .subscription2)
        self.showPopup(popup)
    }
    
    // MARK: - Custom functions
    
    func configureCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(.category)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(.preset)
    }
    
    // MARK: - @IBActions
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsVC = SettingsViewController.load(from: .settings)
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @IBAction func userPresetsButtonPressed(_ sender: Any) {
        let userPresetsVC = UserPresetsViewController.load(from: .userPresets)
        self.navigationController?.pushViewController(userPresetsVC, animated: true)
    }
    
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.category.rawValue, for: indexPath) as! CategoryCollectionViewCell
        cell.categoryNameLabel.text = categories[indexPath.row]
        if currentCategoryID == indexPath.row {
            cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell.lineView.isHidden = false
        } else {
            cell.categoryNameLabel.textColor = UIColor(red: 97/255, green: 103/255, blue: 134/255, alpha: 1)
            cell.lineView.isHidden = true
        }
        return cell
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        cell.presetImage.image = UIImage(named: images[indexPath.row])
        if presetIsFree {
            cell.presetButton.setTitle("FREE PRESETS", for: .normal)
            cell.presetButton.backgroundColor = UIColor(red: 1, green: 71/255, blue: 181/255, alpha: 1)
            // TO SHOW DESIGN
            presetIsFree = false
        } else {
            cell.presetButton.setTitle("PREMIUM PRESETS", for: .normal)
            cell.presetButton.backgroundColor = UIColor(red: 1, green: 71/255, blue: 71/255, alpha: 1)
        }
        cell.presetButton.isUserInteractionEnabled = false
        cell.completion = {}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        let presetVC = PresetViewController.load(from: .preset)
        self.navigationController?.pushViewController(presetVC, animated: true)
    }
}
