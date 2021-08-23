import UIKit

extension UIViewController {
    
    func showPopup(_ popup: UIViewController) {
        self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParent: self)
    }
    
    static func load(from screen: Screen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.info.id) as! Self
    }
    
}
