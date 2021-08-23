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
    
    let flowLayout = CarouselCollectionViewFlowLayout()
    let presets = ["preset-image2", "preset-image2", "preset-image2"]
    var inMyPresets = false
    var didLayoutSubviews = true
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAccessButton.setImage(Images.Icons.note, for: .normal)
        
        howToUseButton.layer.cornerRadius = 8
        howToUseButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        presetsCountView.layer.cornerRadius = presetsCountView.frame.height / 2
        
        self.updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        if didLayoutSubviews {
            configureCollectionView()
            collectionView.reloadData()
            didLayoutSubviews = false
        }
    }
    
    // MARK: - Custom functions
    
    func configureCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(.presetImage)
        
        let itemWidth: CGFloat = UIScreen.main.bounds.width / 1.13636364
        let itemHeight: CGFloat = collectionView.frame.height - 20
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemShift = 5
        flowLayout.sideItemScale = 1
        flowLayout.spacingMode = .overlap(visibleOffset: 10)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    func updateUI() {

        if inMyPresets {
            
            addToMyButton.isUserInteractionEnabled = false
            
            addToMyButton.setImage(Images.Icons.done, for: .normal)
            addToMyButton.setTitle("Added!", for: .normal)
            addToMyButton.setTitleColor(UIColor(red: 128/255, green: 240/255, blue: 131/255, alpha: 1), for: .normal)
            
        } else {
            
            addToMyButton.isUserInteractionEnabled = true
            
            let gradientColor = gradientColor(bounds: addToMyButton.bounds, colors: [
                CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
                CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1),
            ])
            
            addToMyButton.setImage(Images.Icons.gradientAdd, for: .normal)
            addToMyButton.setTitle("Add to my presets", for: .normal)
            addToMyButton.setTitleColor(gradientColor, for: .normal)
            
        }

        inMyPresets = !inMyPresets
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToMyButtonPressed(_ sender: Any) {
        self.updateUI()
    }
    
    @IBAction func getAccessButtonPressed(_ sender: Any) {
        let controller = SubscriptionSecondViewController.load(from: .subscription2)
        controller.closeButtonIsHidden = true
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
        dots.numberOfPages = presets.count
        return presets.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.presetImage.rawValue, for: indexPath) as! PresetImageCollectionViewCell
        cell.imageView.image = UIImage(named: presets[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int((collectionView.contentOffset.x / collectionView.frame.width).rounded(.toNearestOrAwayFromZero))
    }
}
