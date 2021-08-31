import Foundation

struct State {
    
    // MARK: - Variables
    
    private static var appLaunch: Int = 0
    static var language: Language = .en
    static var favouritePresets: [Int] = []
    
    static var selectedPreset: Preset = .defaultPreset
    
    // MARK: - Functions
    
    public static func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
        
        Preset.get()
        Preset.getFavorites()
        
    }
    
    public static func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
    }
    
    public static func isFirstLaunch() -> Bool {
        return self.appLaunch == 1
    }
    
}
