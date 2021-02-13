//
//  UIView+DynamicSize.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

extension UIView {
    public func setDynamicSize() {
        let sizeToFit = CGSize(width: 10000, height: 10000)
        let dynamicSize = systemLayoutSizeFitting(
            sizeToFit,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        frame.size = CGSize(
            width: dynamicSize.width,
            height: dynamicSize.height
        )
    }
    
    public func setDynamicSize(forWidth width: Double) {
        let sizeToFit = CGSize(width: width, height: 10000)
        let dynamicSize = systemLayoutSizeFitting(
            sizeToFit,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        frame.size = CGSize(
            width: CGFloat(width),
            height: dynamicSize.height
        )
    }
    
    public func setDynamicSize(forHeight height: Double) {
        let sizeToFit = CGSize(width: 1000, height: height)
        let dynamicSize = systemLayoutSizeFitting(
            sizeToFit,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        frame.size = CGSize(
            width: dynamicSize.width,
            height: CGFloat(height)
        )
    }
}
