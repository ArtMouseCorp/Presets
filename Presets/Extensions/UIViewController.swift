import UIKit

extension UIViewController {
    
    func showPopup(_ popup: UIViewController) {
        self.addChild(popup)
        popup.view.frame = self.view.frame
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(popup.view)
        }, completion: nil)
        popup.didMove(toParent: self)
    }
    
    static func load(from screen: Screen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.info.id) as! Self
    }
    
}
