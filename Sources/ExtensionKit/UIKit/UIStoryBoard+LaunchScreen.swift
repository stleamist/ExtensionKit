import UIKit

public extension UIStoryboard {
    static var launchScreen: UIStoryboard? {
        guard let launchStoryboardName = Bundle.main.object(forInfoDictionaryKey: "UILaunchStoryboardName") as? String else {
            return nil
        }
        return UIStoryboard(name: launchStoryboardName, bundle: .main)
    }
}
