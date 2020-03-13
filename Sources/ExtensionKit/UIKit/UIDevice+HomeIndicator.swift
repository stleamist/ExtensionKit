import UIKit

public extension UIDevice {
    var hasHomeIndicatorArea: Bool? {
        // AppDelegate에서 window의 makeKeyAndVisible()이 호출되기 전에는 nil 값이 반환되므로,
        // 그 전에는 AppDelegate에서 window를 가져오도록 한다.
        guard let window: UIWindow = UIApplication.shared.keyWindow ?? UIApplication.shared.delegate?.window ?? nil else {
            return nil
        }
        let bottomSafeAreaInsets = window.safeAreaInsets.bottom
        return bottomSafeAreaInsets > 0
    }
}
