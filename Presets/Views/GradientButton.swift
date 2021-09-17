import UIKit

class GradientButton: UIButton {

    enum GradientButtonType {
        case blueGradientButton, redGradientButton
    }
    
    override func awakeFromNib() {
        configureButton()
    }
    
    func configureButton() {
        
        titleLabel?.font = UIFont(name: "EuclidCircularA-SemiBold", size: 14)
        tintColor = UIColor.white
        titleLabel?.textColor = UIColor.white
        layer.cornerRadius = 11
        clipsToBounds = true
        
        layer.shadowRadius = 27
        layer.shadowOffset = CGSize(width: 0, height: 7)
        layer.shadowOpacity = 1
        
        layer.shadowColor = CGColor(red: 52/255, green: 77/255, blue: 215/255, alpha: 0.25)
        
    }
    
    func initialize(as type: GradientButtonType) {
        switch type {
        case .blueGradientButton:
            layer.shadowColor = CGColor(red: 52/255, green: 77/255, blue: 215/255, alpha: 0.25)
            applyGradient(colors: [
                CGColor(red: 68/255, green: 143/255, blue: 1, alpha: 1),
                CGColor(red: 22/255, green: 36/255, blue: 114/255, alpha: 1)
            ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: bounds.insetBy(dx: 0, dy: -1 * bounds.size.height))
        case .redGradientButton:
            layer.shadowColor = CGColor(red: 159/255, green: 37/255, blue: 81/255, alpha: 0.25)
            applyGradient(colors: [
                CGColor(red: 255/255, green: 68/255, blue: 135/255, alpha: 1),
                CGColor(red: 114/255, green: 22/255, blue: 55/255, alpha: 1)
            ], startPoint: CGPoint(x: 0.3, y: -0.5), endPoint: CGPoint(x: 1, y: 0.15), bounds: bounds.insetBy(dx: 0, dy: -1 * bounds.size.height))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        flash()
    }
    
}
