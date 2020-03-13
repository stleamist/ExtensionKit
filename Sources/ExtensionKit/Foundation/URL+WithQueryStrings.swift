import Foundation

public extension URL {
    func withQueryStrings(_ queryStrings: [String: String]) -> URL {
        let queryItems = queryStrings.map({ URLQueryItem(name: $0, value: $1) })
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            return self
        }
        return url
    }
}
