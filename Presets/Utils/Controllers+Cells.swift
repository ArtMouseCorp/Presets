import UIKit

public enum Storyboard: String {
    case Main = "Main"
}

public enum Screen {
    case splash
    case onboarding
    case subscription
    case subscriptionPlans
    case main
    case userPresets
    case defaultPopup
    case manual
    case settings
    case preset
    case settingsPopup
    case mainNav
}

extension Screen {
    
    var info: (id: String, storyboard: Storyboard) {
        switch self {
        case .splash:
            return ("SplashViewController", .Main)
        case .onboarding:
            return ("OnboardingViewController", .Main)
        case .subscription:
            return ("SubscriptionViewController", .Main)
        case .defaultPopup:
            return ("DefaultPopupViewController", .Main)
        case .subscriptionPlans:
            return ("SubscriptionPlansViewController", .Main)
        case .main:
            return ("MainViewController", .Main)
        case .userPresets:
            return ("UserPresetsViewController", .Main)
        case .settings:
            return ("SettingsViewController", .Main)
        case .manual:
            return ("ManualViewController", .Main)
        case .preset:
            return ("PresetViewController", .Main)
        case .settingsPopup:
            return("SettingsPopupViewController", .Main)
        case .mainNav:
            return ("MainNavigationController", .Main)
        }
    }
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.info.storyboard.rawValue, bundle: nil)
    }
}

public enum Cell: String {
    case preset         = "PresetTableViewCell"
    case presetImage    = "PresetImageCollectionViewCell"
    case category       = "CategoryCollectionViewCell"
}

extension Cell {
    var nib: UINib {
        return UINib(nibName: self.rawValue, bundle: nil)
    }
}
