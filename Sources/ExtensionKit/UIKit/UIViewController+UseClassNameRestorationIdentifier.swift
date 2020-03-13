import UIKit

public extension UIViewController {
    func useClassNameRestorationIdentifier() {
        self.restorationIdentifier = String(describing: Self.self)
    }
}
