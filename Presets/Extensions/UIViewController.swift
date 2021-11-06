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
    
    public func showPaywall(animated: Bool = true, single: Bool = true) {
        let subscription = SubscriptionViewController.load(from: .subscription)
        let subPlans = SubscriptionPlansViewController.load(from: .subscriptionPlans)
        let toShow = single ? subscription : subPlans
        
        self.addChild(toShow)
        toShow.view.frame = self.view.frame
        toShow.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        self.view.addSubview(toShow.view)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn) {
            toShow.view.transform = .identity
        }
        toShow.didMove(toParent: self)
    }
    
    public func showSettings() {
        let settingsNavigationController = SettingsNavigationController.load(from: .settingsNav)
        self.addChild(settingsNavigationController)
        settingsNavigationController.view.frame = self.view.frame
        settingsNavigationController.view.transform = CGAffineTransform(translationX: (0 - self.view.frame.width), y: 0)
        self.view.addSubview(settingsNavigationController.view)
        
        UIView.animate(withDuration: 0.3, animations: {
            settingsNavigationController.view.transform = .identity
        }, completion: nil)
        settingsNavigationController.didMove(toParent: self)
    }
    
    static func load(from screen: Screen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.info.id) as! Self
    }
    
    func showNetworkConnectionAlert(completion: (() -> Void)? = nil) {
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
    
    func showAlreadySubscribedAlert(completion: (() -> Void)? = nil) {
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
    
    func showNotSubscriberAlert(completion: (() -> Void)? = nil) {
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
    
    func showRestoredAlert(completion: (() -> Void)? = nil) {
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
    
    func showLoader() {
        let alert = UIAlertController(title: nil, message: L10n.Alert.Loading.message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader(completion: (() -> Void)? = nil) {
        dismiss(animated: false, completion: completion)
    }
    
}
