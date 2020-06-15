import Combine

@available(iOS 13.0, *)
public extension Publisher {
    func printError() -> Publishers.HandleEvents<Self> {
        return self.handleEvents(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                Swift.print("receive error: \(error)")
            }
        })
    }
}
