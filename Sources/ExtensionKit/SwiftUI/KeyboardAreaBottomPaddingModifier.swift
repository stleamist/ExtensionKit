// Source: https://stackoverflow.com/a/58402607/6663613
// Animation properties: https://stackoverflow.com/a/42904976/6663613

import SwiftUI
import Combine

@available(iOS 13.0, *)
struct KeyboardAreaBottomPaddingModifier: ViewModifier {

    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .edgesIgnoringSafeArea(keyboardHeight == 0 ? [] : .bottom)
            .animation(.interpolatingSpring(mass: 3, stiffness: 1000, damping: 500))
            .onAppear(perform: subscribeToKeyboardEvents)
    }

    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height }

    private let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }

    private func subscribeToKeyboardEvents() {
        _ = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.keyboardHeight, on: self)
    }
}

@available(iOS 13.0, *)
public extension View {
    func insetsBottomPaddingFromKeyboardArea() -> some View {
        self.modifier(KeyboardAreaBottomPaddingModifier())
    }
}
