import UIKit

class Preset: Codable, Equatable {
    
    let id: Int
    let name: String
    let titleImage: String
    let isFree: Bool
    let images: [String]
    let presets: [String]
    
    var titleImageURL: URL = URL(string: "apple.com")!
    
    init(id: Int, name: String, titleImage: String, isFree: Bool, images: [String], presets: [String]) {
        self.id = id
        self.name = name
        self.titleImage = titleImage
        self.isFree = isFree
        self.images = images
        self.presets = presets
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, titleImage, isFree, images, presets
    }
    
    static var all: [Preset] = []
    static var free: [Preset] = []
    static var premium: [Preset] = []
    static var favorites: [Preset] = []
    
    static let defaultPreset = Preset(id: 0, name: "", titleImage: "", isFree: false, images: [], presets: [])
    
    static func get() {
        
        self.all.removeAll()
        let jsonData = readLocalJSONFile(forName: "presets")!
        do {
            let decodedData = try JSONDecoder().decode([Preset].self, from: jsonData)
            self.all = decodedData
        } catch {
            print("error: \(error)")
        }
        
        // MARK: - Get all Free and Premium
        
        self.free.removeAll()
        self.premium.removeAll()
        
        all.forEach { preset in
            
            preset.loadTitleImage()
            
            if preset.isFree {
                free.append(preset)
            } else {
                premium.append(preset)
            }
        }
    }
    
    public func loadTitleImage() {
        StorageManager.sharedInstance.getDataURL(path: "presets/\(self.name)/\(self.titleImage)") { result in
            
            switch result {
            case .success(let url):
                self.titleImageURL = url
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
//    public func loadPresetFile(completion: @escaping ((Data) -> ())) {
//
//        StorageManager.sharedInstance.getData(path: "presets/\(self.name)/\(self.presets[0])") { result in
//
//            switch result {
//
//            case .success(let data):
//                completion(data)
//
//            case .failure(let error):
//                print(error)
//
//            }
//
//        }
//
//    }
    
    func getImages() -> [UIImage?] {
        
        var images = [UIImage?]()
        self.images.forEach { imageString in
            let imageName = imageString.components(separatedBy: ".")[0]
            let imageType = imageString.components(separatedBy: ".")[1]
            images.append(getLocalImage(forName: imageName, ofType: imageType))
        }
        
        return images
    }
    
    public static func getFavorites() {
        self.favorites.removeAll()
        State.favouritePresets = userDefaults.array(forKey: UDKeys.favouritePresets) as? [Int] ?? []
        State.favouritePresets.forEach { favPresetId in
            
            let favPreset = self.all.filter { preset in
                return preset.id == favPresetId
            }
            
            self.favorites.append(contentsOf: favPreset)
        }
    }
    
    func addToFavorites() {
        State.favouritePresets.append(self.id)
        userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
        Preset.getFavorites()
    }
    
    func removeFromFavorites() {
        State.favouritePresets.removeAll { presetid in
            return presetid == self.id
        }
        userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
        Preset.getFavorites()
    }
    
    static func == (lhs: Preset, rhs: Preset) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
}
