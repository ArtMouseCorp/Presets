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
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.6
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}
