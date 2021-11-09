import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Collection Views
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var presetsCollectionView: UICollectionView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var userPresetsButton: UIButton!
    
    // MARK: - Variables
    
    var categories: [String] = []
    var selectedCategoryIndex: Int = 0
    
    var isViewDidLayoutSubviews: Bool = false
    
    let ALL = L10n.Main.allPresets
    let FREE = L10n.Main.freePresets
    let PREMIUM = L10n.Main.premiumPresets
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreManager.updateStatus()
        localize()
        configureCategories()
        callPaywall()
    }
    
    override func viewDidLayoutSubviews() {
        guard !isViewDidLayoutSubviews else { return }
        configurePresetsCollectionView()
        configureCategoriesCollectionView()
        isViewDidLayoutSubviews = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.titleLabel.localize(with: L10n.Main.title)
    }
    
    private func configureUI() {
    }
    
    private func configurePresetsCollectionView() {
        
        presetsCollectionView.delegate = self
        presetsCollectionView.dataSource = self
        presetsCollectionView.registerCell(.presetsCollectionCell)
        
        presetsCollectionView.isPagingEnabled = true
        presetsCollectionView.showsHorizontalScrollIndicator = false
        presetsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: presetsCollectionView.frame.height
        )
        
        presetsCollectionView.collectionViewLayout = layout
        
    }
    
    private func configureCategoriesCollectionView() {
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.registerCell(.category)
        
        if let layout = categoriesCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.sectionInset = .zero
        }
    }
    
    func configureCategories() {
        self.categories = Preset.free.isEmpty ? [ALL, PREMIUM] : [ALL, FREE, PREMIUM]
        self.categories.append(contentsOf: Preset.all.map {return $0.name} )
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
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case categoriesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.category.rawValue, for: indexPath) as! CategoryCollectionViewCell
            
            cell.configure(with: categories[indexPath.row], selected: selectedCategoryIndex == indexPath.row)
            
            return cell
            
        case presetsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.presetsCollectionCell.rawValue, for: indexPath) as! PresetsCollectionViewCell
            
            cell.reloadTableViewFor(indexPath: indexPath)
            
            cell.onPresetTap = {
                
                let presetVC = PresetViewController.load(from: .preset)
                presetVC.presetId = State.selectedPreset.id
                self.navigationController?.pushViewController(presetVC, animated: true)
                
            }
            
            return cell
            
        default: return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
            
        case categoriesCollectionView:
            
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            
            self.selectedCategoryIndex = indexPath.row
            self.categoriesCollectionView.reloadData()
            self.categoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.presetsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.presetsCollectionView.reloadItems(at: [indexPath])
            
        default: ()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.presetsCollectionView.reloadItems(at: [indexPath])
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard let collectionView = scrollView as? UICollectionView else { return }
        guard collectionView == presetsCollectionView else { return }

        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)

        guard let indexPath = presetsCollectionView.indexPathForItem(at: center) else { return }

        self.selectedCategoryIndex = indexPath.row
        self.categoriesCollectionView.reloadData()
        self.categoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//        self.presetsCollectionView.reloadItems(at: [indexPath])

    }
    
}


