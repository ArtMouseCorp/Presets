import Foundation
import StoreKit

extension SKProduct {
    
    public static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var isFree: Bool {
        price == 0.00
    }
    
    var localizedPrice: String? {
        guard !isFree else {
            return nil
        }
        
        let formatter = SKProduct.formatter
        formatter.locale = priceLocale
        
        return formatter.string(from: price)
    }
    
    func getSubscriptionPeriod(showUnits: Bool = false) -> String {
        
        let perdiod = self.subscriptionPeriod
        let numberOfUnits = perdiod?.numberOfUnits ?? 0
        
        var unit = ""
        
        switch perdiod!.unit {
            
        case .day:
            let oneDay = L10n.Subscription.Interval.Day.one
            let twoDays = L10n.Subscription.Interval.Day.two
            let fiveDays = L10n.Subscription.Interval.Day.five
            
            unit = getNoun(number: numberOfUnits, one: oneDay, two: twoDays, five: fiveDays)
        case .week:
            let oneWeek = L10n.Subscription.Interval.Week.one
            let twoWeeks = L10n.Subscription.Interval.Week.two
            let fiveWeeks = L10n.Subscription.Interval.Week.five
            
            unit = getNoun(number: numberOfUnits, one: oneWeek, two: twoWeeks, five: fiveWeeks)
        case .month:
            let oneMonth = L10n.Subscription.Interval.Month.one
            let twoMonths = L10n.Subscription.Interval.Month.two
            let fiveMonths = L10n.Subscription.Interval.Month.five
            
            unit = getNoun(number: numberOfUnits, one: oneMonth, two: twoMonths, five: fiveMonths)
        case .year:
            let oneYear = L10n.Subscription.Interval.Year.one
            let twoYears = L10n.Subscription.Interval.Year.two
            let fiveYears = L10n.Subscription.Interval.Year.five
            
            unit = getNoun(number: numberOfUnits, one: oneYear, two: twoYears, five: fiveYears)
        @unknown default:
            unit = "N/A"
        }
        
        if showUnits {
            return "\(numberOfUnits) " + unit
        } else {
            return numberOfUnits > 1 ? "\(numberOfUnits) " + unit : unit
        }
    }
    
    func getTrialPeriod() -> String? {
        
        let perdiod = self.introductoryPrice?.subscriptionPeriod
        let numberOfUnits = perdiod?.numberOfUnits ?? 0
        
        var unit = ""
        
        switch perdiod?.unit {
            
        case .day:
            let oneDay = L10n.Subscription.Interval.Day.one
            let twoDays = L10n.Subscription.Interval.Day.two
            let fiveDays = L10n.Subscription.Interval.Day.five
            
            unit = getNoun(number: numberOfUnits, one: oneDay, two: twoDays, five: fiveDays)
        case .week:
            let oneWeek = L10n.Subscription.Interval.Week.one
            let twoWeeks = L10n.Subscription.Interval.Week.two
            let fiveWeeks = L10n.Subscription.Interval.Week.five
            
            unit = getNoun(number: numberOfUnits, one: oneWeek, two: twoWeeks, five: fiveWeeks)
        case .month:
            let oneMonth = L10n.Subscription.Interval.Month.one
            let twoMonths = L10n.Subscription.Interval.Month.two
            let fiveMonths = L10n.Subscription.Interval.Month.five
            
            unit = getNoun(number: numberOfUnits, one: oneMonth, two: twoMonths, five: fiveMonths)
        case .year:
            let oneYear = L10n.Subscription.Interval.Year.one
            let twoYears = L10n.Subscription.Interval.Year.two
            let fiveYears = L10n.Subscription.Interval.Year.five
            
            unit = getNoun(number: numberOfUnits, one: oneYear, two: twoYears, five: fiveYears)
        case .none:
            return nil
        @unknown default:
            unit = "N/A"
        }
        
        return "\(numberOfUnits) " + unit.uppercased()
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
