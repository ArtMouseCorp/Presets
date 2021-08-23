import UIKit

extension UIView {
    
    func applyGradient(type: CAGradientLayerType = .axial, colors: [CGColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1), bounds: CGRect? = nil) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors
        gradient.frame = self.bounds
        gradient.bounds = bounds ?? self.bounds
        gradient.locations = [0, 1]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGesture(target: Any?, action: Selector?) {
        let gesture = UIGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
}
