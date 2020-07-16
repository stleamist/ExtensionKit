import Swift

public extension CaseIterable where Self: Equatable {
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex(of: self)!
    }
    
    init?(index: Self.AllCases.Index) {
        guard Self.allCases.indices.contains(index) else {
            return nil
        }
        self = Self.allCases[index]
    }
}
