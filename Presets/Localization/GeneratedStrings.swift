// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Alert {
    internal enum Action {
      /// Ok
      internal static let ok = L10n.tr("Localizable", "alert.action.ok")
    }
    internal enum Connection {
      /// There is no internet connection. Please connect to the network and try again.
      internal static let message = L10n.tr("Localizable", "alert.connection.message")
      /// No internet connection
      internal static let title = L10n.tr("Localizable", "alert.connection.title")
    }
    internal enum NotSubscriber {
      /// Sorry, you cannot restore your purchase because you do not have an active subscription.
      internal static let message = L10n.tr("Localizable", "alert.notSubscriber.message")
      /// Cannot be restored
      internal static let title = L10n.tr("Localizable", "alert.notSubscriber.title")
    }
    internal enum Restored {
      /// You have successfully restored your subscription. All functionality is now available to you.
      internal static let message = L10n.tr("Localizable", "alert.restored.message")
      /// Restored
      internal static let title = L10n.tr("Localizable", "alert.restored.title")
    }
    internal enum Subscribed {
      /// You are already subscribed. All functionality is available to you.
      internal static let message = L10n.tr("Localizable", "alert.subscribed.message")
      /// Subscribed
      internal static let title = L10n.tr("Localizable", "alert.subscribed.title")
    }
  }

  internal enum Delete {
    /// Delete preset?
    internal static let title = L10n.tr("Localizable", "delete.title")
    internal enum Button {
      /// No, cancel
      internal static let cancel = L10n.tr("Localizable", "delete.button.cancel")
      /// Yes, delete
      internal static let confirm = L10n.tr("Localizable", "delete.button.confirm")
    }
  }

  internal enum Main {
    /// All
    internal static let allPresets = L10n.tr("Localizable", "main.allPresets")
    /// Free
    internal static let freePresets = L10n.tr("Localizable", "main.freePresets")
    /// PREMIUM
    internal static let premiumPresets = L10n.tr("Localizable", "main.premiumPresets")
    /// Lightroom presets
    internal static let title = L10n.tr("Localizable", "main.title")
  }

  internal enum Manual {
    /// How to use?
    internal static let title = L10n.tr("Localizable", "manual.title")
    internal enum Button {
      /// Install Adobe Lightroom
      internal static let lightroom = L10n.tr("Localizable", "manual.button.lightroom")
      /// Watch video tutorial
      internal static let videoTutorial = L10n.tr("Localizable", "manual.button.videoTutorial")
    }
    internal enum Hint {
      /// * Presets are displayed with DNG mark
      internal static let first = L10n.tr("Localizable", "manual.hint.first")
      /// ** Feel free to try different presets and change settings to make your photo perfect
      internal static let second = L10n.tr("Localizable", "manual.hint.second")
    }
    internal enum Step {
      /// 5. When the photo is added, click the "More" button and select "Insert settings"
      internal static let fifth = L10n.tr("Localizable", "manual.step.fifth")
      /// 1. Install Adobe Lightroom from the App Store
      internal static let first = L10n.tr("Localizable", "manual.step.first")
      /// 4. Press the "Back" button to return to the previous screen, then press the "Import" button and select a photo from your library
      internal static let fourth = L10n.tr("Localizable", "manual.step.fourth")
      /// 2. Select a preset and click "Copy to Lightroom"
      internal static let second = L10n.tr("Localizable", "manual.step.second")
      /// 6. Great! Now you can save the photo or share it with subscribers
      internal static let sixth = L10n.tr("Localizable", "manual.step.sixth")
      /// 3. The preset will open in Lightroom, click the more button and select "Copy Settings"
      internal static let third = L10n.tr("Localizable", "manual.step.third")
    }
  }

  internal enum MyPresets {
    /// Here will be the saved presets
    internal static let placeholder = L10n.tr("Localizable", "myPresets.placeholder")
    /// My Presets
    internal static let title = L10n.tr("Localizable", "myPresets.title")
    internal enum Button {
      /// Select a preset
      internal static let select = L10n.tr("Localizable", "myPresets.button.select")
    }
  }

  internal enum Onboarding {
    internal enum Subtitle {
      /// Import presets into Lightroom
      internal static let first = L10n.tr("Localizable", "onboarding.subtitle.first")
      /// Style your work
      internal static let second = L10n.tr("Localizable", "onboarding.subtitle.second")
      /// Beginner friendly
      internal static let third = L10n.tr("Localizable", "onboarding.subtitle.third")
    }
    internal enum Title {
      /// Amazing photos in minutes
      internal static let first = L10n.tr("Localizable", "onboarding.title.first")
      /// Select a style and apply it
      internal static let second = L10n.tr("Localizable", "onboarding.title.second")
      /// Enjoy 100+ Lightroom presets
      internal static let third = L10n.tr("Localizable", "onboarding.title.third")
    }
  }

  internal enum OpenPreset {
    /// Do you know how to use presets?
    internal static let title = L10n.tr("Localizable", "openPreset.title")
    internal enum Button {
      /// Yes, open a preset
      internal static let `open` = L10n.tr("Localizable", "openPreset.button.open")
      /// No, open the manual
      internal static let openManual = L10n.tr("Localizable", "openPreset.button.openManual")
    }
  }

  internal enum Preset {
    /// Added!
    internal static let addedPreset = L10n.tr("Localizable", "preset.addedPreset")
    /// Tap to open the preset
    internal static let tapHint = L10n.tr("Localizable", "preset.tapHint")
    internal enum Button {
      /// Add to my presets
      internal static let addToMyPresets = L10n.tr("Localizable", "preset.button.addToMyPresets")
      /// How to use?
      internal static let manual = L10n.tr("Localizable", "preset.button.manual")
      /// Get access to 100+ presets
      internal static let subscription = L10n.tr("Localizable", "preset.button.subscription")
    }
    internal enum Count {
      /// presets
      internal static let five = L10n.tr("Localizable", "preset.count.five")
      /// preset
      internal static let one = L10n.tr("Localizable", "preset.count.one")
      /// presets
      internal static let two = L10n.tr("Localizable", "preset.count.two")
    }
  }

  internal enum Privacy {
    /// Privacy Policy
    internal static let title = L10n.tr("Localizable", "privacy.title")
  }

  internal enum ServiceTerms {
    /// Terms of Service
    internal static let title = L10n.tr("Localizable", "serviceTerms.title")
  }

  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings.title")
    internal enum Button {
      /// Contact us
      internal static let contact = L10n.tr("Localizable", "settings.button.contact")
      /// How to use?
      internal static let manual = L10n.tr("Localizable", "settings.button.manual")
      /// Privacy Policy
      internal static let policy = L10n.tr("Localizable", "settings.button.policy")
      /// Recover your purchases
      internal static let restorePurchase = L10n.tr("Localizable", "settings.button.restorePurchase")
      /// Terms of Service
      internal static let serviceTerms = L10n.tr("Localizable", "settings.button.serviceTerms")
    }
  }

  internal enum Subscription {
    /// Over 100+ quality presets
    internal static let subtitle = L10n.tr("Localizable", "subscription.subtitle")
    /// Become pro!
    internal static let title = L10n.tr("Localizable", "subscription.title")
    internal enum Button {
      /// Next
      internal static let next = L10n.tr("Localizable", "subscription.button.next")
      /// Privacy
      internal static let privacy = L10n.tr("Localizable", "subscription.button.privacy")
      /// Restore
      internal static let restore = L10n.tr("Localizable", "subscription.button.restore")
      /// Terms
      internal static let terms = L10n.tr("Localizable", "subscription.button.terms")
    }
    internal enum Failed {
      /// Cancel or pause at any time
      internal static let cancelInfo = L10n.tr("Localizable", "subscription.failed.cancelInfo")
      /// Purchase run limited version
      internal static let limitedVersion = L10n.tr("Localizable", "subscription.failed.limitedVersion")
      /// Purchase failed :(
      internal static let subtitle = L10n.tr("Localizable", "subscription.failed.subtitle")
      /// Oooops!
      internal static let title = L10n.tr("Localizable", "subscription.failed.title")
      /// View ads to
      internal static let title2 = L10n.tr("Localizable", "subscription.failed.title2")
      internal enum Button {
        /// Try 3 days of access
        internal static let trial = L10n.tr("Localizable", "subscription.failed.button.trial")
      }
      internal enum Trial {
        /// ...or try full access with a 3-day free trial
        internal static let title = L10n.tr("Localizable", "subscription.failed.trial.title")
      }
    }
    internal enum Interval {
      internal enum Day {
        /// days
        internal static let five = L10n.tr("Localizable", "subscription.interval.day.five")
        /// day
        internal static let one = L10n.tr("Localizable", "subscription.interval.day.one")
        /// days
        internal static let two = L10n.tr("Localizable", "subscription.interval.day.two")
      }
      internal enum Month {
        /// months
        internal static let five = L10n.tr("Localizable", "subscription.interval.month.five")
        /// month
        internal static let one = L10n.tr("Localizable", "subscription.interval.month.one")
        /// months
        internal static let two = L10n.tr("Localizable", "subscription.interval.month.two")
      }
      internal enum Week {
        /// weeks
        internal static let five = L10n.tr("Localizable", "subscription.interval.week.five")
        /// week
        internal static let one = L10n.tr("Localizable", "subscription.interval.week.one")
        /// weeks
        internal static let two = L10n.tr("Localizable", "subscription.interval.week.two")
      }
      internal enum Year {
        /// years
        internal static let five = L10n.tr("Localizable", "subscription.interval.year.five")
        /// year
        internal static let one = L10n.tr("Localizable", "subscription.interval.year.one")
        /// years
        internal static let two = L10n.tr("Localizable", "subscription.interval.year.two")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
