import UIKit

public enum Storyboard: String {
    case Main = "Main"
}

public enum Screen {
    case loading
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
    case settingsNav
    case saleOffer
    case subscriptionFirst
    case subscriptionSecond
    case subscriptionThird
}

extension Screen {
    
    var info: (id: String, storyboard: Storyboard) {
        switch self {
        case .loading:
            return ("LoadingViewController", .Main)
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
        case .settingsNav:
            return ("SettingsNavigationController", .Main)
        case .saleOffer:
            return ("SaleOfferViewController", .Main)
        case .subscriptionFirst:
            return ("SubscriptionFirstViewController", .Main)
        case .subscriptionSecond:
            return ("SubscriptionSecondViewController", .Main)
        case .subscriptionThird:
            return ("SubscriptionThirdViewController", .Main)
        }
    }
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.info.storyboard.rawValue, bundle: nil)
    }
}

public enum Cell: String {
    case preset                 = "PresetTableViewCell"
    case presetImage            = "PresetImageCollectionViewCell"
    case category               = "CategoryCollectionViewCell"
    case presetCategory         = "PresetCategoryCollectionViewCell"
    case presetsCollectionCell  = "PresetsCollectionViewCell"
}

extension Cell {
    var nib: UINib {
        return UINib(nibName: self.rawValue, bundle: nil)
    }
}
