import UIKit
import GoogleMobileAds
import Amplitude
import SkarbSDK

class BaseSubscriptionViewController: BaseViewController {
    
    // MARK: - Variables
    
    private var interstitial: GADInterstitialAd?
    
    public var sourceViewController: BaseViewController!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createAndLoadInterstitialAd()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Amplitude.instance().logEvent(AmplitudeEvents.paywallClose)
    }
    
    // MARK: - Custom functions
    
    private func createAndLoadInterstitialAd() {
        
        let request = GADRequest()
        
        GADInterstitialAd.load(withAdUnitID: Keys.AdmMod.unitId, request: request) { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        
    }
    
    public func showInterstitialAd() {
        
        guard let interstitial = interstitial else {
            print("Ad wasn't ready")
            self.dismiss(animated: true)
            return
        }
        
        interstitial.present(fromRootViewController: self)
        Amplitude.instance().logEvent(AmplitudeEvents.afterSubscriptionAd)
    }
    
    public func close(showAd: Bool = true) {
        
        guard State.isSubscribed || !showAd else {
            
            // Show ad
            self.showInterstitialAd()
            return
        }
        
        self.dismiss(animated: true)
    }
    
}

extension BaseSubscriptionViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will dismiss full screen content.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        self.dismiss(animated: true)
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
