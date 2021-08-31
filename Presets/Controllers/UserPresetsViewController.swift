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
            
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Custom functions
    
    func configureView() {
        toHideView.isHidden = !(State.favouritePresets.count == 0)
        tableView.isHidden = State.favouritePresets.count == 0
        if State.favouritePresets.count != 0 {
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
        return State.favouritePresets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        cell.completion = {
            let popup = DefaultPopupViewController.load(from: .defaultPopup)
            popup.initialize(as: .deletePresetPopup)
            popup.deleteIndex = indexPath.row
            popup.completion = {
                hapticFeedback(.success)
                self.tableView.reloadData()
                self.configureView()
            }
            self.showPopup(popup)
        }
        
        let indexOfPreset = State.favouritePresets[indexPath.row]
        cell.presetImage.image = Preset.all[indexOfPreset].getTitleImage()
        
        cell.presetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.presetButton.setImage(Images.Icons.trash, for: .normal)
        cell.presetButton.backgroundColor = UIColor(red: 249/255, green: 48/255, blue: 48/255, alpha: 1)
        cell.presetButton.layer.cornerRadius = 22
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfPreset = State.favouritePresets[indexPath.row]
        State.selectedPreset = Preset.all[indexOfPreset]
        let presetVC = PresetViewController.load(from: .preset)
        self.navigationController?.pushViewController(presetVC, animated: true)
    }
    
}
