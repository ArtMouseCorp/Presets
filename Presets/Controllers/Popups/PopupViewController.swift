import UIKit

class PopupViewController: UIViewController {

    // MARK: - Awake Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    // MARK: - Custom Functions
    
    func configureBackground() {
        view.backgroundColor = UIColor(red: 0.058, green: 0.082, blue: 0.217, alpha: 0.65)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.insertSubview(blurEffectView, at: 0)
        
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.view.addGestureRecognizer(backgroundTap)
    }
    
    // MARK: - @objc Functions
    
    @objc func backgroundTapped() { }
}
