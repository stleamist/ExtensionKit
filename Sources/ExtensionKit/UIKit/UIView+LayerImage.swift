import UIKit

public extension UIView {
    func layerImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
}
