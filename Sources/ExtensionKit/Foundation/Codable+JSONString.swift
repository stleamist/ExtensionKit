import Foundation

public extension Encodable {
    func jsonString(options: JSONEncoder.OutputFormatting = .prettyPrinted) throws -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = options
        
        let jsonStringData = try encoder.encode(self)
        
        return String(data: jsonStringData, encoding: .utf8)
    }
}

public extension Decodable {
    private init(jsonData: Data) throws {
        let decoded = try JSONDecoder().decode(Self.self, from: jsonData)
        self = decoded
    }
    
    init?(jsonString: String) throws {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        try self.init(jsonData: jsonData)
    }
    
    init(jsonURL: URL) throws {
        let jsonData = try Data(contentsOf: jsonURL)
        try self.init(jsonData: jsonData)
    }
}
