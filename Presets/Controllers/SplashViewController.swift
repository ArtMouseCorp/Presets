import UIKit

class SplashViewController: BaseViewController {

    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let onboardingVC = OnboardingViewController.load(from: .onboarding)
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
}

