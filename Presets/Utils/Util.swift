import UIKit

func getGradientColor(bounds: CGRect, colors: [CGColor]) -> UIColor? {
    
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = colors
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    
    UIGraphicsBeginImageContext(gradient.bounds.size)
    //create UIImage by rendering gradient layer.
    gradient.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    //get gradient UIcolor from gradient UIImage
    return UIColor(patternImage: image!)
}

public func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

public func getLocalImage(forName name: String, ofType type: String) -> UIImage? {

    if let filePath = Bundle.main.path(forResource: name, ofType: type) {
        return UIImage(contentsOfFile: filePath)
    }
    return nil
}
