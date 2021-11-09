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
        localize()
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
    
    private func localize() {
        self.titleLabel.localize(with: L10n.MyPresets.title)
        self.hereWillBePresetsLabel.localize(with: L10n.MyPresets.placeholder)
        self.selectPresetButton.localize(with: L10n.MyPresets.Button.select)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(.preset)
    }

    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectPresetButtonPressed(_ sender: Any) {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
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
        
        let presetId = State.favouritePresets[indexPath.row]
        guard let preset = Preset.all.first(where: { $0.id == presetId }) else { return cell }
        
        cell.configure(with: preset, button: .delete)
        
        cell.onButtonPress = {
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
        let presetId = State.favouritePresets[indexPath.row]
        guard let preset = Preset.all.first(where: {$0.id == presetId}) else { return }
        State.selectedPreset = preset
        let presetVC = PresetViewController.load(from: .preset)
        presetVC.presetId = presetId
        self.navigationController?.pushViewController(presetVC, animated: true)
    }
    
}
