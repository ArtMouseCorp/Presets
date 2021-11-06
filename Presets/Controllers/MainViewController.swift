import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Collection Views
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var presetsCollectionView: UICollectionView!
    
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
        StoreManager.updateStatus()
        localize()
        setupItemsArray()
        configureCollectionView()
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
        
        presetsCollectionView.delegate = self
        presetsCollectionView.dataSource = self
    }
    
    func setupItemsArray() {
        items = Preset.free.count == 0 ? [ALL, PREMIUM] : [ALL, FREE, PREMIUM]
        Preset.all.forEach { preset in
            items.append(preset.name)
        }
    }
    
    private func callPaywall() {
        guard !State.isSubscribed else { return }
        self.showPaywall()
    }
    
    // MARK: - @IBActions
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        self.showSettings()
    }
    
    @IBAction func userPresetsButtonPressed(_ sender: Any) {
        let userPresetsVC = UserPresetsViewController.load(from: .userPresets)
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        self.navigationController?.pushViewController(userPresetsVC, animated: true)
    }
}



// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Preset.free.count == 0 ? Preset.all.count + 2 : Preset.all.count + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
        
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.presetCategory.rawValue, for: indexPath) as! PresetCategoryCollectionViewCell
            
            // MARK: - Number of rows in table view
            
            cell.items = items
            
            if indexPath.row == 0 {
                cell.countOfRowsInTableView = Preset.all.count
            } else if indexPath.row == 1 {
                cell.countOfRowsInTableView = Preset.free.count
            } else if indexPath.row == 2 {
                cell.countOfRowsInTableView = Preset.premium.count
            } else {
                cell.countOfRowsInTableView = 1
            }
            
            cell.navigationController = self.navigationController!
            
            cell.currentCategoryID = indexPath.row
            cell.tableViewWidthConstraint.constant = UIScreen.main.bounds.width
            cell.tableViewHeightConstraint.constant = collectionView.frame.height
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            
            lastCategotID = currentCategoryID
            currentCategoryID = indexPath.row
            let oldIndexPath = IndexPath(item: lastCategotID, section: 0)
            
            presetsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let collectionViewWithTableView = self.presetsCollectionView.cellForItem(at: indexPath) as! PresetCategoryCollectionViewCell
                collectionViewWithTableView.tableView.reloadData()
                collectionViewWithTableView.tableView.isHidden = false
            }
            
            guard let oldCell = collectionView.cellForItem(at: oldIndexPath) as? CategoryCollectionViewCell else {
                let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
                cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                cell.lineView.isHidden = false
                
                return
            }
            oldCell.categoryNameLabel.textColor = UIColor(red: 97/255, green: 103/255, blue: 134/255, alpha: 1)
            oldCell.lineView.isHidden = true
            
            let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell.lineView.isHidden = false
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView {
            return 20
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView {
            return 20
        } else {
            return 0
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            if collectionView == self.presetsCollectionView {
                let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
                let yPoint = scrollView.frame.height / 2
                let center = CGPoint(x: xPoint, y: yPoint)
                
                if let item = presetsCollectionView.indexPathForItem(at: center) {
                    lastCategotID = currentCategoryID
                    currentCategoryID = item.row
                    
                    let indexPath = IndexPath(item: currentCategoryID, section: 0)
                    let oldIndexPath = IndexPath(item: lastCategotID, section: 0)
                    
                    guard let collectionViewWithTableView = presetsCollectionView.cellForItem(at: indexPath) as? PresetCategoryCollectionViewCell else {
                        return
                    }
                    collectionViewWithTableView.tableView.reloadData()
                    collectionViewWithTableView.tableView.isHidden = false
                    
                    guard let oldCell = self.collectionView.cellForItem(at: oldIndexPath) as? CategoryCollectionViewCell else {
                        guard let cell = self.collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {
                            return
                        }
                        cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.lineView.isHidden = false
                        return
                    }
                    oldCell.categoryNameLabel.textColor = UIColor(red: 97/255, green: 103/255, blue: 134/255, alpha: 1)
                    oldCell.lineView.isHidden = true
                    
                    guard let cell = self.collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {
                        return
                    }
                    cell.categoryNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.lineView.isHidden = false
                    
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    
                }
            }
        }
    }
    
}

    
