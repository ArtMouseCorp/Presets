import UIKit

class BlueGradientButton: GradientButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureButton() {
        super.configureButton()
        
        layer.shadowColor = CGColor(red: 52/255, green: 77/255, blue: 215/255, alpha: 0.25)
        updateGradient()
    }
    
    public func updateGradient() {
        titleLabel?.textAlignment = .center
        applyGradient(colors: [
            CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
            CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1)
        ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: bounds.insetBy(dx: 0, dy: -1 * bounds.size.height))
    }
    
}
