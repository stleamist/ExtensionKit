import Foundation

public extension NSCoder {
    
    func decodeCodable<T: Codable>(forKey key: String) -> T? {
        if let jsonString = self.decodeObject(forKey: key) as? String {
            return try? T(jsonString: jsonString)
        }
        return nil
    }
    
    func encodeCodable(_ value: Codable, forKey key: String) {
        if let jsonString = try? value.jsonString(options: []) {
            self.encode(jsonString, forKey: key)
        }
    }
}
