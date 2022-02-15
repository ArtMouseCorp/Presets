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
