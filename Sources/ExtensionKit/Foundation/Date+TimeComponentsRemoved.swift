import Foundation

public extension Date {
    var timeComponentsRemoved: Self {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        guard let date = Calendar.current.date(from: dateComponents) else {
            assertionFailure("Failed to remove time components from the Date.")
            return Date(timeIntervalSince1970: 0)
        }
        return date
    }
}
