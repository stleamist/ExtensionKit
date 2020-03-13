import Foundation

public extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension String {
    
    subscript (safe range: ClosedRange<Index>) -> String.SubSequence? {
        return indices.contains(range.upperBound) && indices.contains(range.lowerBound) ? self[range] : nil
    }
}

public extension Array {
    @discardableResult mutating func removeIfExists(at position: Int) -> Element? {
        guard indices.contains(position) else {
            return nil
        }
        
        return self.remove(at: position)
    }
}
