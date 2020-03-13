import Foundation

private let choseongUnits = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ".map({ $0 })
private let jungseongUnits = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ".map({ $0 })
private let jongseongUnits = "ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ".map({ $0 })

private let gyeopmoeum: [Character: [Character]] = [
    "ㅘ": "ㅗㅏ",
    "ㅙ": "ㅗㅐ",
    "ㅚ": "ㅗㅣ",
    "ㅝ": "ㅜㅓ",
    "ㅞ": "ㅜㅔ",
    "ㅟ": "ㅜㅣ",
    "ㅢ": "ㅡㅣ"
].mapValues({ $0.map({ $0 }) })

private let gyeopbatchim: [Character: [Character]] = [
    "ㄳ": "ㄱㅅ",
    "ㄵ": "ㄴㅈ",
    "ㄶ": "ㄴㅎ",
    "ㄺ": "ㄹㄱ",
    "ㄻ": "ㄹㅁ",
    "ㄼ": "ㄹㅂ",
    "ㄽ": "ㄹㅅ",
    "ㄾ": "ㄹㅌ",
    "ㄿ": "ㄹㅍ",
    "ㅀ": "ㄹㅎ",
    "ㅄ": "ㅂㅅ",
].mapValues({ $0.map({ $0 }) })

public extension String {

    var fastDecomposedHangeulString: String {
        return self.decomposedStringWithCanonicalMapping.unicodeScalars.reduce(into: "") { (result, scalar) in
            let scalarValue = Int(scalar.value)

            switch scalarValue {
            case 0x1100...0x1112:
                let index = Int(scalar.value - 0x1100)
                result += String(choseongUnits[index])
            case 0x1161...0x1175:
                let index = Int(scalar.value - 0x1161)
                let jungseong = jungseongUnits[index]
                result += gyeopmoeum[jungseong] ?? [jungseong]
            case 0x11A8...0x11C2:
                let index = Int(scalar.value - 0x11A8)
                let jongseong = jongseongUnits[index]
                result += gyeopbatchim[jongseong] ?? [jongseong]
            default:
                result += String(scalar)
            }
        }
    }

    func fastHangeulDecomposedRange(of searchString: String) -> Range<String.Index>? {

        if self.fastDecomposedHangeulString.contains(searchString.fastDecomposedHangeulString) {
            if searchString.fastDecomposedHangeulString.count == 1 {
                return self.range(of: self.filter({ String($0).fastDecomposedHangeulString.contains(searchString.fastDecomposedHangeulString) }))
            }
            if let range = self.localizedStandardRange(of: searchString) {
                return range
            }
            if let range = self.localizedStandardRange(of: searchString) ?? self.localizedStandardRange(of: searchString.dropLast()) {
                return range
            }
        }

        return nil
    }
}

public extension String {
    
    var decomposedCharacters: [Character] {
        return self.decomposedStringWithCanonicalMapping.unicodeScalars.map({ Character($0) })
    }
    
    var decomposedHangeulCharacters: [Character] {
        return self.decomposedStringWithCanonicalMapping.unicodeScalars.map { (scalar) -> Character in
            let scalarValue = Int(scalar.value)
            
            switch scalarValue {
            case 0x1100...0x1112:
                let index = Int(scalar.value - 0x1100)
                return choseongUnits[index]
            case 0x1161...0x1175:
                let index = Int(scalar.value - 0x1161)
                return jungseongUnits[index]
//                return gyeopmoeum[jungseong] ?? [jungseong]
            case 0x11A8...0x11C2:
                let index = Int(scalar.value - 0x11A8)
                return jongseongUnits[index]
//                return gyeopbatchim[jongseong] ?? [jongseong]
            default:
                return Character(scalar)
            }
        }
    }
    
    func decomposedRange(of searchString: String) -> Range<String.Index>? {
        for lowerIndex in self.indices {
            if String(self[lowerIndex]).decomposedCharacters.starts(with: String(searchString[searchString.startIndex]).decomposedCharacters) {
                if String(self[lowerIndex...]).decomposedCharacters.starts(with: searchString.decomposedCharacters) {
                    return lowerIndex..<self.index(lowerIndex, offsetBy: searchString.count)
                }
            }
        }
        
        return nil
    }
    
    func localizedStandardDecomposedRange(of searchString: String) -> Range<String.Index>? {
        let foldedSelf = self.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: Locale.current)
        let foldedSearchString = self.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: Locale.current)
        
        guard let foldedDecomposedRange = foldedSelf.hangeulDecomposedRange(of: foldedSearchString) else {
            return nil
        }
        
        let foldedDecomposedNSRange = NSRange(foldedDecomposedRange, in: foldedSelf)
        
        return self.index(self.startIndex, offsetBy: foldedDecomposedNSRange.location)..<self.index(self.startIndex, offsetBy: foldedDecomposedNSRange.location + foldedDecomposedNSRange.length)
    }
    
    func hangeulDecomposedRange(of searchString: String) -> Range<String.Index>? {
        for lowerIndex in self.indices {
            // FIXME: decomposedHangeulCharacters에 접근하면 느려진다
            if String(self[lowerIndex]).decomposedHangeulCharacters.starts(with: String(searchString[searchString.startIndex]).decomposedHangeulCharacters) {
                if String(self[lowerIndex...]).decomposedHangeulCharacters.starts(with: searchString.decomposedHangeulCharacters) {
                    return lowerIndex..<self.index(lowerIndex, offsetBy: searchString.count)
                }
            }
        }
        
        return nil
    }
}

public extension Array where Element: Equatable {
    
    @inlinable public func firstRange(of otherElements: [Element]) -> Range<Int>? {
        for lowerIndex in 0..<self.count {
            if self[lowerIndex] == otherElements.first {
                if self[lowerIndex...].starts(with: otherElements) {
                    return lowerIndex..<(lowerIndex + otherElements.count)
                }
            }
        }
        
        return nil
    }
}
