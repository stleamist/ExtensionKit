import UIKit

public extension UIView {
    
    func constrainToParent() {
        constrainToParent(insets: .zero)
    }
    
    func constrainToParent(insets: UIEdgeInsets) {
        guard let parent = superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: insets.bottom),
            self.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: insets.right)
        ])
    }
}
