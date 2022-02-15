import UIKit

class PresetViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var presetsCountView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presetsCountLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var howToUseButton: BlueGradientButton!
    @IBOutlet weak var addToMyButton: UIButton!
    @IBOutlet weak var getAccessButton: BlueGradientButton!
    
    // CollectionViews
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Page control
    @IBOutlet weak var dots: UIPageControl!
    
    // MARK: - Variables
    
    var isFavorite = false
    var didLayoutSubviews = true
    var isTapped = false
    
    var imagesURLs: [URL] = []
    
    // MARK: - Constants
    
    let cellWidth = UIScreen.main.bounds.width - 60
    let sectionSpacing:CGFloat = 30
    let cellSpacing:CGFloat = 15
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImages()
        
        localize()
        
        self.isFavorite = State.selectedPreset.isFavorite()
        
        
        howToUseButton.layer.cornerRadius = 8
        howToUseButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        presetsCountView.layer.cornerRadius = presetsCountView.frame.height / 2
        self.updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        if didLayoutSubviews {
            DispatchQueue.main.async {
                self.configureCollectionView()
                self.collectionView.reloadData()
                self.didLayoutSubviews = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.updateUI()
                self.howToUseButton.updateGradient()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleLabel.text = State.selectedPreset.name
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.howToUseButton.localize(with: L10n.Preset.Button.manual)
        if State.isSubscribed {
            self.getAccessButton.localize(with: L10n.Preset.Button.openPreset)
        } else {
            self.getAccessButton.localize(with: L10n.Preset.Button.subscription)
        }
    }
    
    func configureCollectionView() {
        
        let itemHeight: CGFloat = collectionView.frame.height
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(.presetImage)
        
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: itemHeight)
        layout.minimumLineSpacing = cellSpacing
        layout.velocityThresholdPerPage = 5
        collectionView.decelerationRate = .fast
        collectionView.collectionViewLayout = layout
    }
    
    private func fetchImages() {
        
        self.imagesURLs = State.selectedPreset.getPreviewURLs()
        
        self.collectionView.reloadData()
        
        let presetsCount = self.imagesURLs.count
        let presetNoun = getNoun(
            number: presetsCount,
            one: L10n.Preset.Count.one,
            two: L10n.Preset.Count.two,
            five: L10n.Preset.Count.five
        )
        
        self.presetsCountLabel.text = "\(presetsCount) \(presetNoun)"
    }
    
    func updateUI() {
        
        if isFavorite {
            
            addToMyButton.isUserInteractionEnabled = false
            
            addToMyButton.setImage(Images.Icons.done, for: .normal)
            addToMyButton.setTitle(L10n.Preset.addedPreset, for: .normal)
            addToMyButton.setTitleColor(UIColor(red: 128/255, green: 240/255, blue: 131/255, alpha: 1), for: .normal)
            
        } else {
            
            addToMyButton.isUserInteractionEnabled = true
            
            let gradientColor = getGradientColor(bounds: addToMyButton.bounds, colors: [
                CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
                CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1),
            ])
            
            addToMyButton.setImage(Images.Icons.gradientAdd, for: .normal)
            addToMyButton.setTitle(L10n.Preset.Button.addToMyPresets, for: .normal)
            addToMyButton.setTitleColor(gradientColor, for: .normal)
            
        }
        
        isFavorite = !isFavorite
        
    }
    
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.collectionView.visibleCells {
            let indexPath = self.collectionView.indexPath(for: cell)
            return indexPath
        }
        return nil
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToMyButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        guard State.isSubscribed || State.selectedPreset.isFree else {
            self.showPaywall()
            return
        }
        
        State.favouritePresets.append(State.selectedPreset.id)
        userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
        hapticFeedback(.success)
        self.updateUI()
    }
    
    @IBAction func getAccessButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        if State.isSubscribed {
            let popup = DefaultPopupViewController.load(from: .defaultPopup)
            popup.initialize(as: .openPresetPopup)
            popup.indexOfImagePreset = visibleCurrentCellIndexPath?.row ?? 0
            popup.completion = { }
            self.showPopup(popup)
        } else {
            self.showPaywall()
        }
        
    }
    
    @IBAction func howToUseButtonPressed(_ sender: Any) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        let manualVC = ManualViewController.load(from: .manual)
        self.navigationController?.pushViewController(manualVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PresetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dots.numberOfPages = imagesURLs.count
        return imagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.presetImage.rawValue, for: indexPath) as! PresetImageCollectionViewCell
        
        cell.configure(with: imagesURLs[indexPath.row], isFirst: indexPath.row == 0)
        cell.presetNameLabel.text = "\(State.selectedPreset.name) \(indexPath.row + 1)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        if let firstCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? PresetImageCollectionViewCell, firstCell.openPresetView != nil {
            firstCell.openPresetView.removeFromSuperview()
        }
        
        let popup = DefaultPopupViewController.load(from: .defaultPopup)
        popup.initialize(as: .openPresetPopup)
        popup.indexOfImagePreset = indexPath.row
        popup.completion = { }
        self.showPopup(popup)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let collectionView = scrollView as? UICollectionView else { return }
        guard collectionView == self.collectionView else { return }
        
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        
        guard let indexPath = self.collectionView.indexPathForItem(at: center) else { return }
        
        dots.currentPage = indexPath.row
        
    }
    
}
