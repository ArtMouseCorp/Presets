import UIKit

class PopupViewController: UIViewController {

    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
    }
    
    // MARK: - Custom functions
    
    func configureBackground() {
        view.backgroundColor = UIColor(red: 0.058, green: 0.082, blue: 0.217, alpha: 0.65)
//        view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.backgroundColor = UIColor(red: 0.058, green: 0.082, blue: 0.217, alpha: 0.65)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.insertSubview(blurEffectView, at: 0)
    }
}
