//
//  UIView+DynamicSize.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

extension UIView {
    public func setDynamicSize(forWidth width: Double) {
        let sizeToFit = CGSize(width: width, height: 10000)
        let cellSize = systemLayoutSizeFitting(
            sizeToFit,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        frame.size = CGSize(
            width: CGFloat(width),
            height: cellSize.height
        )
    }
    
    public func setDynamicSize(forHeight height: Double) {
        let sizeToFit = CGSize(width: 1000, height: height)
        let cellSize = systemLayoutSizeFitting(
            sizeToFit,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        frame.size = CGSize(
            width: cellSize.width,
            height: CGFloat(height)
        )
    }
}
