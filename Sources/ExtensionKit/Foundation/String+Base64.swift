import Foundation

public extension String {
    init?(base64Encoded base64String: String, key keyString: String? = nil) {
        let data: Data!
        
        if let keyString = keyString {
            data = Data(base64Encoded: base64String, key: keyString)
        } else {
            data = Data(base64Encoded: base64String)
        }
        
        self.init(data: data, encoding: .utf8)
    }
    
    func translating(from fromKeyString: String, to toKeyString: String) -> String? {
        guard fromKeyString.count == toKeyString.count else {
            return nil
        }
        
        let translationTable = Dictionary(uniqueKeysWithValues: zip(Array(fromKeyString), Array(toKeyString)))
        
        let charArray = self.map({ translationTable[$0] ?? $0 })
        
        return String(charArray)
    }
    
    mutating func translate(from fromTableString: String, to toTableString: String) {
        self = self.translating(from: fromTableString, to: toTableString) ?? self
    }
}

public extension Data {
    init?(base64Encoded base64String: String, key keyString: String, options: Data.Base64DecodingOptions = Base64DecodingOptions(rawValue: 0)) {
        let standardKeyString = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        
        let base64Translated = base64String.translating(from: standardKeyString, to: keyString)
        self.init(base64Encoded: base64Translated ?? base64String, options: options)
    }
}
