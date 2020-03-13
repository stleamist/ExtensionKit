import Foundation

public extension URLComponents {
    var fragmentItems: [URLQueryItem]? {
        get {
            var components = URLComponents()
            components.query = fragment
            return components.queryItems
        }
        set {
            var components = URLComponents()
            components.queryItems = newValue
            self.fragment = components.query
        }
    }
}
