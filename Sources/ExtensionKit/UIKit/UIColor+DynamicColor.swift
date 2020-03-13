import UIKit

public extension UIColor {
    @available(iOS 13.0, *)
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle != .dark {
                return light
            } else {
                return dark
            }
        }
    }
}
