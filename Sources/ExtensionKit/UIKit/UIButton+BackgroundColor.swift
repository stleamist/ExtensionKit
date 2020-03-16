//
//  UIButton+BackgroundColor.swift
//  A UIButton extension to set the color of its background, supporting dynamic colors introduced in iOS 13.
//
//  Created by Dongkyu Kim on 2019/01/15.
//  Copyright © 2019 Dongkyu Kim. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// Sets the color of the background to use for the specified state.
    ///
    /// In general, if a property is not specified for a state, the default is to use the [normal](apple-reference-documentation://hsOohbJNGp) value.
    /// If the normal value is not set, then the property defaults to a system value.
    /// Therefore, at a minimum, you should set the value for the normal state.
    /// - Author: [Dongkyu Kim](https://gist.github.com/stleamist)
    /// - Parameters:
    ///     - color: The color of the background to use for the specified state
    ///     - cornerRadius: The radius, in points, for the rounded corners on the button. The default value is 8.0.
    ///     - state: The state that uses the specified color. The possible values are described in [UIControl.State](apple-reference-documentation://hs-yI2haNm).
    ///
    func setBackgroundColor(_ color: UIColor?, cornerRadius: CGFloat = 8.0, for state: UIControl.State) {
        
        guard let color = color else {
            self.setBackgroundImage(nil, for: state)
            return
        }
        
        let length = 1 + cornerRadius * 2
        let size = CGSize(width: length, height: length)
        let rect = CGRect(origin: .zero, size: size)
        
        var backgroundImage = UIGraphicsImageRenderer(size: size).image { (context) in
            // Fill the square with the black color for later tinting.
            color.setFill()
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).fill()
        }
        
        backgroundImage = backgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
        
        // Apply the `color` to the `backgroundImage` as a tint color
        // so that the `backgroundImage` can update its color automatically when the currently active traits are changed.
        if #available(iOS 13.0, *) {
            backgroundImage = backgroundImage.withTintColor(color, renderingMode: .alwaysOriginal)
        }
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
