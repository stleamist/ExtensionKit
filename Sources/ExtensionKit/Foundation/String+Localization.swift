import Foundation

public extension String {
    func localized(tableName: String? = nil, bundle: Bundle = Bundle.main, value: String? = nil, comment: String? = nil) -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value ?? self, comment: comment ?? "")
    }
    
    func formatted(_ variables: CVarArg...) -> String {
        return String(format: self, arguments: variables)
    }
}
