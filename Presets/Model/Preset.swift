import UIKit

struct Preset: Codable {
    
    let id: Int
    let name: String
    let titleImage: String
    let isFree: Bool
    let images: [String]
    let presets: [String]
    
    static var all: [Preset] = []
    static var free: [Preset] = []
    static var premium: [Preset] = []
    static var favorites: [Preset] = []
    
    static let defaultPreset = Preset(id: 0, name: "Preset", titleImage: "", isFree: true, images: [], presets: [])
    
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
            if preset.isFree {
                free.append(preset)
            } else {
                premium.append(preset)
            }
        }
    }
    
    func getTitleImage() -> UIImage? {
        let imageName = titleImage.components(separatedBy: ".")[0]
        let imageType = titleImage.components(separatedBy: ".")[1]
        return getLocalImage(forName: imageName, ofType: imageType)
    }
    
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
    
}
