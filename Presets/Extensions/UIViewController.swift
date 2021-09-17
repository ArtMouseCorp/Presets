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
    
    func showNetworkConnectionAlert(completion: (() -> Void)?) {
        let alertOk = UIAlertAction(title: L10n.Alert.Action.ok, style: .default) { action in
            completion?() ?? ()
        }
        self.present(getAlert(title: L10n.Alert.Connection.title,
                              message: L10n.Alert.Connection.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    func showAlreadySubscribedAlert(completion: (() -> Void)?) {
        let alertOk = UIAlertAction(title: L10n.Alert.Action.ok, style: .default) { action in
            completion?() ?? ()
        }
        self.present(getAlert(title: L10n.Alert.Subscribed.title,
                              message: L10n.Alert.Subscribed.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    func showNotSubscriberAlert(completion: (() -> Void)?) {
        let alertOk = UIAlertAction(title: L10n.Alert.Action.ok, style: .default) { action in
            completion?() ?? ()
        }
        self.present(getAlert(title: L10n.Alert.NotSubscriber.title,
                              message: L10n.Alert.NotSubscriber.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    func showRestoredAlert(completion: (() -> Void)?) {
        let alertOk = UIAlertAction(title: L10n.Alert.Action.ok, style: .default) { action in
            completion?() ?? ()
        }
        self.present(getAlert(title: L10n.Alert.Restored.title,
                              message: L10n.Alert.Restored.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
}
