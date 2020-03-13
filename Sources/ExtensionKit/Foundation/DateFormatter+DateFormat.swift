import Foundation

public extension DateFormatter {
    convenience init(withFormat format: String) {
        self.init()
        self.dateFormat = format
    }
}
