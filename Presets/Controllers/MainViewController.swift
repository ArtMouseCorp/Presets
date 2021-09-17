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
    
    var currentCategoryID = 0
    var lastCategotID = 0
    var items: [String] = []
    
    let ALL = L10n.Main.allPresets
    let FREE = L10n.Main.freePresets
    let PREMIUM = L10n.Main.premiumPresets
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paywallConfig = RCValues.sharedInstance.organicSubscriptionPage()
        State.currentProductId = paywallConfig.subscriptionId
        checkSubscription()
        localize()
        setupItemsArray()
        configureCollectionView()
        configureTableView()
        callPaywall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.titleLabel.localize(with: L10n.Main.title)
    }
    
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
    
    func setupItemsArray() {
        items = Preset.free.count == 0 ? [ALL, PREMIUM] : [ALL, FREE, PREMIUM]
        Preset.all.forEach { preset in
            items.append(preset.name)
        }
    }
    
    private func callPaywall() {
        guard !State.isSubscribed else { return }
        let subscription = SubscriptionViewController.load(from: .subscription)
        self.showPopup(subscription)
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
        return Preset.free.count == 0 ? Preset.all.count + 2 : Preset.all.count + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.category.rawValue, for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryNameLabel.text = items[indexPath.item]
        
        if currentCategoryID == indexPath.row {
            cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell.lineView.isHidden = false
        } else {
            cell.categoryNameLabel.textColor = UIColor(red: 97/255, green: 103/255, blue: 134/255, alpha: 1)
            cell.lineView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        lastCategotID = currentCategoryID
        currentCategoryID = indexPath.row
        let oldIndexPath = IndexPath(item: lastCategotID, section: 0)
        
        guard let oldCell = collectionView.cellForItem(at: oldIndexPath) as? CategoryCollectionViewCell else {
            let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell.lineView.isHidden = false
            tableView.reloadData()
            return
        }
        oldCell.categoryNameLabel.textColor = UIColor(red: 97/255, green: 103/255, blue: 134/255, alpha: 1)
        oldCell.lineView.isHidden = true
        
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lineView.isHidden = false
        
        tableView.reloadData()
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentCategoryID == 0 {
            return Preset.all.count
        } else if items[currentCategoryID] == FREE {
            return Preset.free.count
        } else if items[currentCategoryID] == PREMIUM {
            return Preset.premium.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        
        if currentCategoryID == 0 {
            cell.presetImage.image = Preset.all[indexPath.row].getTitleImage()
        } else if items[currentCategoryID] == FREE {
            cell.presetImage.image = Preset.free[indexPath.row].getTitleImage()
        } else if items[currentCategoryID] == PREMIUM {
            cell.presetImage.image = Preset.premium[indexPath.row].getTitleImage()
        } else {
            Preset.all.forEach { preset in
                if preset.name == items[currentCategoryID] {
                    cell.presetImage.image = preset.getTitleImage()
                }
            }
        }
        
        if Preset.all[indexPath.row].isFree {
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
        self.navigationController?.pushViewController(presetVC, animated: true)
        
    }
}
