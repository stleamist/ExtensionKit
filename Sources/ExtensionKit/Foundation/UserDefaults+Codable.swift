import Foundation

public extension UserDefaults {
    
    func codable<T: Codable>(forKey defaultName: String) -> T? {
        if let jsonString = self.string(forKey: defaultName) {
            return try? T(jsonString: jsonString)
        }
        return nil
    }
    
    // 메소드 이름을 set(_:forKey:)으로 지으면 기존 메소드와의 모호성으로 이 메소드의 무한 루프가 발생하므로 주의한다.
    func setCodable(_ value: Codable, forKey defaultName: String) {
        if let jsonString = try? value.jsonString(options: []) {
            self.set(jsonString, forKey: defaultName)
        }
    }
}
