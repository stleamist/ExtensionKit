#if canImport(Combine)

import Combine

@available(iOS 13.0, macOS 10.15, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Publisher {
    func printError() -> Publishers.HandleEvents<Self> {
        return self.handleEvents(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                Swift.print("receive error: \(error)")
            }
        })
    }
}

#endif
