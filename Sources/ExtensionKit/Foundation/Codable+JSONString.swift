import Foundation

public extension Encodable {
    func jsonString(options: JSONEncoder.OutputFormatting = .prettyPrinted) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = options
        
        guard let jsonStringData = try? encoder.encode(self) else {
            return nil
        }
        
        return String(data: jsonStringData, encoding: .utf8)
    }
}

public extension Decodable {
    init?(jsonString: String) {
        guard let jsonStringData = jsonString.data(using: .utf8) else {
            return nil
        }
        guard let decoded = try? JSONDecoder().decode(Self.self, from: jsonStringData) else {
            return nil
        }
        self = decoded
    }
}
