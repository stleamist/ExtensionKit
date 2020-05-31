import Foundation

public extension URLQueryItem {
    static func items(from string: String) -> [URLQueryItem]? {
        var components = URLComponents()
        components.query = string
        return components.queryItems
    }
}
