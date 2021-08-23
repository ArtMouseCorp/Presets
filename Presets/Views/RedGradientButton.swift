import UIKit

class RedGradientButton: GradientButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureButton() {
        super.configureButton()
        
        layer.shadowColor = CGColor(red: 159/255, green: 37/255, blue: 81/255, alpha: 0.25)
        applyGradient(colors: [
            CGColor(red: 255/255, green: 68/255, blue: 135/255, alpha: 1),
            CGColor(red: 114/255, green: 22/255, blue: 55/255, alpha: 1)
        ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: bounds.insetBy(dx: 0, dy: -1 * bounds.size.height))
    }

}
