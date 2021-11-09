import UIKit

class PresetsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets
    
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var categories: [String] = []
    var presets: [Preset] = []
    
    var onPresetTap: (() -> ())? = nil
    
    let ALL = L10n.Main.allPresets
    let FREE = L10n.Main.freePresets
    let PREMIUM = L10n.Main.premiumPresets
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
        configureCategories()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(.preset)
    }
    
    private func configureCategories() {
        self.categories = Preset.free.isEmpty ? [ALL, PREMIUM] : [ALL, FREE, PREMIUM]
        self.categories.append(contentsOf: Preset.all.map {return $0.name} )
    }
    
    public func reloadTableViewFor(indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.presets = Preset.all
        } else if indexPath.row == 1 && !Preset.free.isEmpty {
            self.presets = Preset.free
        } else if indexPath.row == 1 && Preset.free.isEmpty {
            self.presets = Preset.premium
        } else if indexPath.row == 2 && !Preset.free.isEmpty {
            self.presets = Preset.premium
        } else if indexPath.row == 2 && Preset.free.isEmpty {
            self.presets = Preset.all.filter { return $0.id == indexPath.row - 1 }
        } else {
            self.presets = Preset.all.filter { return $0.id == indexPath.row - 2 }
        }
        
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PresetsCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.preset.rawValue, for: indexPath) as! PresetTableViewCell
        
        let preset = presets[indexPath.row]
        
        cell.configure(with: preset, button: .label)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        State.selectedPreset = presets[indexPath.row]
        self.onPresetTap?() ?? ()
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
