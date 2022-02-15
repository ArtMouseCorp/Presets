import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var saleOfferView: UIView!
    
    // Collection Views
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var presetsCollectionView: UICollectionView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerTimeLeftLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var userPresetsButton: UIButton!
    @IBOutlet weak var getOfferButton: UIButton!
    
    // Constraints
    @IBOutlet weak var offerLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var categories: [String] = []
    var selectedCategoryIndex: Int = 0
    var timer = Timer()
    
    let SALE_DURATION: Int = State.saleSubscriptionPage.saleDurationSeconds
    
    var saleOfferStartDate: Date = Date()
    var saleOfferEndDate: Date = Date()
    var saleOfferSecondsLeft: Int = 0
    
    var offerTimeLeftLabelText: String = "0:00:00"
    
    var isViewDidLayoutSubviews: Bool = false
    
    let ALL = L10n.Main.allPresets
    let FREE = L10n.Main.freePresets
    let PREMIUM = L10n.Main.premiumPresets
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        configureCategories()
        
        if !State.isSubscribed {
            self.showPaywall()            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        guard !isViewDidLayoutSubviews else { return }
        configurePresetsCollectionView()
        configureCategoriesCollectionView()
        isViewDidLayoutSubviews = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        calculateSaleOfferEndDate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if timer.isValid {
            timer.invalidate()
        }
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.titleLabel.localize(with: L10n.Main.title)
        
        self.offerTitleLabel.localize(with: State.saleSubscriptionPage.smallSaleOfferView.titleLabel)
        self.offerDescriptionLabel.localize(with: State.saleSubscriptionPage.smallSaleOfferView.descriptionLabel)
        self.getOfferButton.localize(with: State.saleSubscriptionPage.smallSaleOfferView.buttonLabel)
    }
    
    private func configureUI() {
        offerDescriptionLabel.setLineHeight(lineHeight: 3)
        offerDescriptionLabel.sizeToFit()
        offerLabelHeightConstraint.constant = offerDescriptionLabel.frame.height
        
        getOfferButton.layer.cornerRadius = 8
        saleOfferView.layer.cornerRadius = 8
        saleOfferView.clipsToBounds = true
        saleOfferView.applyGradient(colors: [
            CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
            CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1)
        ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: saleOfferView.bounds.insetBy(dx: 0, dy: -1 * saleOfferView.bounds.size.height))
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
        self.categories.append(contentsOf: Preset.all.map { return $0.name } )
    }
    
    private func calculateSaleOfferEndDate() {
        
        saleOfferView.isHidden = true
        
        guard !State.isSubscribed else { return }
        
        State.startSaleOffer()
        
        saleOfferStartDate = State.getStartSaleOfferDate()
        saleOfferEndDate = saleOfferStartDate.addingTimeInterval(TimeInterval(SALE_DURATION))
        saleOfferSecondsLeft = Int(saleOfferEndDate.timeIntervalSince(Date()))
        
        guard saleOfferSecondsLeft > 0 else {
            return
        }
        
        saleOfferView.isHidden = false
        timerStart()
    }
    
    private func timerStart() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setLabelText), userInfo: nil, repeats: true)
    }
    
    @objc private func setLabelText() {
        DispatchQueue.main.async {

            self.saleOfferSecondsLeft = Int(self.saleOfferEndDate.timeIntervalSince(Date()))

            guard self.saleOfferSecondsLeft > 0 else {
                self.timer.invalidate()
                self.saleOfferView.isHidden = true
                return
            }

            let hours = Int(self.saleOfferSecondsLeft / 3600)
            let minutes = Int((self.saleOfferSecondsLeft - hours * 3600) / 60)
            let seconds = Int((self.saleOfferSecondsLeft - hours * 3600) % 60)

            self.offerTimeLeftLabelText = "\(hours):\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
            self.offerTimeLeftLabel.text = "🔥\(self.offerTimeLeftLabelText)"
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func getSaleOfferButtonPressed(_ sender: Any) {
        let offerVC = SaleOfferViewController.load(from: .saleOffer)
        offerVC.modalPresentationStyle = .fullScreen
        offerVC.timeLabelText = self.offerTimeLeftLabelText
        
        offerVC.onClose = { timeText in
            self.offerTimeLeftLabel.text = "🔥\(timeText)"
            self.timerStart()
        }
        
        self.present(offerVC, animated: true, completion: nil)
    }
    
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
            
        default: break
            
        }
        
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
        
    }
    
}


