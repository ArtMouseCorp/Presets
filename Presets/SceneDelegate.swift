import UIKit
import Amplitude
import FBSDKCoreKit
import FBAEMKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        if State.isFirstLaunch() {
            window.rootViewController = OnboardingViewController.load(from: .onboarding)
            Amplitude.instance().logEvent(AmplitudeEvents.firstTimeLaunch)
        } else {
            window.rootViewController = LoadingViewController.load(from: .loading)
            Amplitude.instance().logEvent(AmplitudeEvents.appLaunch)
        }
        
        self.window = window
        window.makeKeyAndVisible()
        
        window.overrideUserInterfaceStyle = .dark
    }
    
    func changeRootViewController(to vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
        
        // add animation
        guard animated else { return }
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.curveEaseInOut, .transitionFlipFromBottom],
                          animations: nil,
                          completion: nil)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        AEMReporter.configure(withNetworker: nil, appID: Keys.Facebook.appId, reporter: nil)
        AEMReporter.enable()
        AEMReporter.handle(url)
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    
}

