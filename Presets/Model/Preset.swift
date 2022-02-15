import UIKit

class Preset: Codable, Equatable {
    
    let id: Int
    let name: String
    let isFree: Bool = false
    let preview: String
    let dng: [String]
    let previews: [String]
    
    init(id: Int, name: String, preview: String, dng: [String], previews: [String]) {
        self.id = id
        self.name = name
        self.preview = preview
        self.dng = dng
        self.previews = previews
    }
    
    public static let `default`: Preset = Preset(id: 0, name: "Default", preview: "", dng: [], previews: [])
    
    private var previewImage: UIImage = UIImage()
    private var previewsURLs: [URL] = []
    
    enum CodingKeys: String, CodingKey {
        case id, name, preview, dng, previews
    }
    
    public static var all: [Preset] = []
    public static var free: [Preset] = []
    public static var premium: [Preset] = []
    
    public func setPreviewImage(to image: UIImage) {
        self.previewImage = image
    }
    
    public func getPreviewImage() -> UIImage {
        return self.previewImage
    }
    
    public func getPreviewURLs() -> [URL] {
        return self.previewsURLs
    }
    
    public func isFavorite() -> Bool {
        return State.favouritePresets.contains(self.id)
    }
 
}

// MARK: - Network Request

extension Preset {
    
    public static func load() {
        
        let urlString = "https://artpoldev.com/api/presets/presets.php?api_key=" + Keys.API.apiKey
        guard let url = URL(string: urlString) else { fatalError() }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("ERROR | FETCHING PRESETS FROM API | Error: \(error!)")
                return
            }

            do {
                let presets = try JSONDecoder().decode([Preset].self, from: data)
                
                presets.forEach { preset in
                    if let url = URL(string: preset.preview), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        preset.setPreviewImage(to: image)
                    }
                    
                    if preset.isFree {
                        self.free.append(preset)
                    } else {
                        self.premium.append(preset)
                    }
                    
                    preset.previewsURLs.removeAll()
                    preset.previews.forEach { preview in
                        
                        if let url = URL(string: preview) {
                            preset.previewsURLs.append(url)
                        }
                        
                    }
                }
                
                self.all = presets
                
            } catch {
                print("ERROR | FETCHING PRESETS FROM API | Error: \(error)")
            }

        }.resume()
        
    }
    
    public func loadDNG(for index: Int, completion: @escaping (Data?) -> ()) {
        
        topController().showLoader()
        
        let urlString = self.dng[index]
        guard let url = URL(string: urlString) else { fatalError() }
        
        let dng = try? Data(contentsOf: url)
        completion(dng)
        
    }
    
}


// MARK: - Identifiable

extension Preset: Identifiable {
    
    static func == (lhs: Preset, rhs: Preset) -> Bool {
        return lhs.id == rhs.id
    }
    
}

//class Preset: Codable, Equatable {
//
//    let id: Int
//    let name: String
//    let titleImage: String
//    let isFree: Bool
//    let images: [String]
//    let presets: [String]
//
//    var titleImageURL: URL = URL(string: "apple.com")!
//    var imagesURLs: [URL] = []
//
//    init(id: Int, name: String, titleImage: String, isFree: Bool, images: [String], presets: [String]) {
//        self.id = id
//        self.name = name
//        self.titleImage = titleImage
//        self.isFree = isFree
//        self.images = images
//        self.presets = presets
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, titleImage, isFree, images, presets
//    }
//
//    static var all: [Preset] = []
//    static var free: [Preset] = []
//    static var premium: [Preset] = []
//    static var favorites: [Preset] = []
//
//    static let defaultPreset = Preset(id: 0, name: "", titleImage: "", isFree: false, images: [], presets: [])
//
//    static func get() {
//
//        self.all.removeAll()
//        let jsonData = readLocalJSONFile(forName: "presets")!
//        do {
//            let decodedData = try JSONDecoder().decode([Preset].self, from: jsonData)
//            self.all = decodedData
//        } catch {
//            print("error: \(error)")
//        }
//
//        // MARK: - Get all Free and Premium
//
//        self.free.removeAll()
//        self.premium.removeAll()
//
//        all.forEach { preset in
//
////            preset.loadTitleImage()
//
//            if preset.isFree {
//                free.append(preset)
//            } else {
//                premium.append(preset)
//            }
//        }
//    }
//
//    public func getTitleImage() -> UIImage? {
//        let imageName = titleImage.components(separatedBy: ".")[0]
//        let imageType = titleImage.components(separatedBy: ".")[1]
//        return getLocalImage(forName: imageName, ofType: imageType)
//    }
//
//    public func loadTitleImage() {
//        StorageManager.sharedInstance.getDataURL(path: "presets/\(self.name)/\(self.titleImage)") { result in
//
//            switch result {
//            case .success(let url):
//                self.titleImageURL = url
//            case .failure(let error):
//                print(error)
//            }
//
//        }
//    }
//
//    public func loadPresetImages(completion: @escaping (() -> ())) {
//
//        let dispatchGroup = DispatchGroup()
//        self.imagesURLs.removeAll()
//        for image in images {
//            dispatchGroup.enter()
//            StorageManager.sharedInstance.getDataURL(path: "presets/\(self.name)/\(image)") { result in
//
//                switch result {
//                case .success(let url):
//                    self.imagesURLs.append(url)
//                    dispatchGroup.leave()
//                case .failure(let error):
//                    print(error)
//                }
//
//            }
//        }
//
//        dispatchGroup.notify(queue: .main) {
//            completion()
//        }
//    }
//
//    public func getDNGData(for index: Int, completion: @escaping ((Data) -> ())) {
//
//        topController().showLoader()
//        StorageManager.sharedInstance.getData(path: "presets/\(self.name)/\(self.presets[index])") { result in
//
//            switch result {
//            case .success(let data):
//                completion(data)
//            case .failure(let error):
//                topController().hideLoader()
//                print(error)
//            }
//
//        }
//    }
//
//    public static func getFavorites() {
//        self.favorites.removeAll()
//        State.favouritePresets = userDefaults.array(forKey: UDKeys.favouritePresets) as? [Int] ?? []
//        State.favouritePresets.forEach { favPresetId in
//
//            let favPreset = self.all.filter { preset in
//                return preset.id == favPresetId
//            }
//
//            self.favorites.append(contentsOf: favPreset)
//        }
//    }
//
//    func addToFavorites() {
//        State.favouritePresets.append(self.id)
//        userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
//        Preset.getFavorites()
//    }
//
//    func removeFromFavorites() {
//        State.favouritePresets.removeAll { presetid in
//            return presetid == self.id
//        }
//        userDefaults.set(State.favouritePresets, forKey: UDKeys.favouritePresets)
//        Preset.getFavorites()
//    }
//
//    static func == (lhs: Preset, rhs: Preset) -> Bool {
//        return lhs.id == rhs.id && lhs.name == rhs.name
//    }
//
//}
