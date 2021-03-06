// Source: https://stackoverflow.com/a/39425959/6663613
import Swift

@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstProperties = unicodeScalars.first?.properties else {
            return false
        }
        return unicodeScalars.count == 1 &&
            (firstProperties.isEmojiPresentation ||
                firstProperties.generalCategory == .otherSymbol)
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool {
        return unicodeScalars.count > 1 &&
            unicodeScalars.contains { $0.properties.isJoinControl || $0.properties.isVariationSelector }
    }
    
    // FIXME: 피부색이 들어간 이모지는 false를 반환하는 문제가 있음
    var isEmoji: Bool {
        return isSimpleEmoji || isCombinedIntoEmoji
    }
}
