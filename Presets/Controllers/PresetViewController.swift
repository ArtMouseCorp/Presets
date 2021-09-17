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
    
    var inMyPresets = false
    var didLayoutSubviews = true
    var presetId = 0
    var isTapped = false
    
    // MARK: - Constants
    
    let cellWidth = UIScreen.main.bounds.width - 60
    let sectionSpacing:CGFloat = 30
    let cellSpacing:CGFloat = 15
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        
        inMyPresets = State.favouritePresets.contains(presetId)
        
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
        
        
        let presetsCount = State.selectedPreset.getImages().count
        let presetNoun = getNoun(
            number: presetsCount,
            one: L10n.Preset.Count.one,
            two: L10n.Preset.Count.two,
            five: L10n.Preset.Count.five
        )
        
        self.presetsCountLabel.text = "\(presetsCount) \(presetNoun)"
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.howToUseButton.localize(with: L10n.Preset.Button.manual)
        self.getAccessButton.localize(with: L10n.Preset.Button.subscription)
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
    
    func updateUI() {

        if inMyPresets {
            
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
        
        inMyPresets = !inMyPresets

    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToMyButtonPressed(_ sender: Any) {
        
        State.favouritePresets.append(presetId)
        userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
        hapticFeedback(.success)
        self.updateUI()
    }
    
    @IBAction func getAccessButtonPressed(_ sender: Any) {
        let controller = SubscriptionViewController.load(from: .subscription)
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func howToUseButtonPressed(_ sender: Any) {
        let manualVC = ManualViewController.load(from: .manual)
        self.navigationController?.pushViewController(manualVC, animated: true)
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PresetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dots.numberOfPages = State.selectedPreset.images.count
        return State.selectedPreset.getImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.presetImage.rawValue, for: indexPath) as! PresetImageCollectionViewCell
        
        cell.imageView.image = State.selectedPreset.getImages()[indexPath.row]
        
        if indexPath.row != 0 {
            if cell.openPresetView != nil {
                cell.openPresetView.isHidden = true
            }
        }
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let firstCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? PresetImageCollectionViewCell else {
            let popup = DefaultPopupViewController.load(from: .defaultPopup)
            popup.initialize(as: .openPresetPopup)
            popup.indexOfImagePreset = indexPath.row
            popup.completion = { }
            self.showPopup(popup)
            return
        }
        if firstCell.openPresetView != nil {
            firstCell.openPresetView.removeFromSuperview()
        }
        
        let popup = DefaultPopupViewController.load(from: .defaultPopup)
        popup.initialize(as: .openPresetPopup)
        popup.indexOfImagePreset = indexPath.row
        popup.completion = { }
        self.showPopup(popup)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int((collectionView.contentOffset.x / collectionView.frame.width).rounded(.toNearestOrAwayFromZero))
    }
}
