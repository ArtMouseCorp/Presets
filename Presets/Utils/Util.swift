import UIKit

func gradientColor(bounds: CGRect, colors: [CGColor]) -> UIColor? {
    
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
