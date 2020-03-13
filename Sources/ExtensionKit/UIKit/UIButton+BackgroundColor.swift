//
//  UIButton+BackgroundColor.swift
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
    ///     - state: The state that uses the specified color. The possible values are described in [UIControl.State](apple-reference-documentation://hs-yI2haNm).
    ///
    @available(iOS 13.0, *)
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        
        guard let color = color else {
            self.setBackgroundImage(nil, for: state)
            return
        }
        
        var backgroundImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { (context) in
            // Fill the square with the black color for later tinting.
            UIColor.black.setFill()
            context.fill(context.format.bounds)
        }
        
        // Apply the `color` to the `backgroundImage` as a tint color
        // so that the `backgroundImage` can update its color automatically when the currently active traits are changed.
        backgroundImage = backgroundImage.withTintColor(color, renderingMode: .alwaysOriginal)
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
