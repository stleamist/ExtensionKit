import Foundation

public extension Encodable {
    func jsonString(custom: ((JSONEncoder) -> Void)? = nil) throws -> String? {
        let encoder = JSONEncoder()
        custom?(encoder)
        let jsonStringData = try encoder.encode(self)
        return String(data: jsonStringData, encoding: .utf8)
    }
}

public extension Decodable {
    private init(jsonData: Data, custom: ((JSONDecoder) -> Void)? = nil) throws {
        let decoder = JSONDecoder()
        custom?(decoder)
        let decoded = try decoder.decode(Self.self, from: jsonData)
        self = decoded
    }
    
    init?(jsonString: String, custom: ((JSONDecoder) -> Void)? = nil) throws {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        try self.init(jsonData: jsonData, custom: custom)
    }
    
    init(jsonURL: URL, custom: ((JSONDecoder) -> Void)? = nil) throws {
        let jsonData = try Data(contentsOf: jsonURL)
        try self.init(jsonData: jsonData, custom: custom)
    }
}
