//
//  UIView+Shadow.swift
//  Interface
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit

public extension UIView {
    func applyShadow(color: UIColor, offset: CGSize = .zero, opacity: Float = 1.0, blur: CGFloat = 0, spread: CGFloat = 0) {
        clipsToBounds = false
        layer.masksToBounds = false

        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        
        layer.shadowRadius = blur / UIScreen.main.scale
        layer.shadowPath = UIBezierPath(rect: bounds.insetBy(dx: -spread, dy: -spread)).cgPath
    }
}
