import UIKit

class UserPresetsViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var toHideView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hereWillBePresetsLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectPresetButton: BlueGradientButton!
        
    // MARK: - Variables
    
    var presetCount = 1
    var images = ["preset1", "preset2"]
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Custom functions
    
    func configureView() {
        toHideView.isHidden = !(presetCount == 0)
        tableView.isHidden = presetCount == 0
        if presetCount != 0 {
            configureTableView()
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(.preset)
    }

    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectPresetButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserPresetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        cell.completion = {
            let popup = DefaultPopupViewController.load(from: .defaultPopup)
            popup.initialize(as: .deletePresetPopup)
            self.showPopup(popup)
        }
        cell.presetImage.image = UIImage(named: images[indexPath.row])
        cell.presetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.presetButton.setImage(Images.Icons.trash, for: .normal)
        cell.presetButton.backgroundColor = UIColor(red: 249/255, green: 48/255, blue: 48/255, alpha: 1)
        cell.presetButton.layer.cornerRadius = 22
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        let presetVC = PresetViewController.load(from: .preset)
        self.navigationController?.pushViewController(presetVC, animated: true)
    }
    
}
