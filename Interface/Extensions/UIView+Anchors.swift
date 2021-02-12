//
//  UIView+Anchors.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

extension UIView {
    
    public func constrainEdges(to view: UIView, inset: CGFloat = 0) {
        topAnchor(equalTo: view.topAnchor, constant: inset)
        bottomAnchor(equalTo: view.bottomAnchor, constant: -inset)
        leadingAnchor(equalTo: view.leadingAnchor, constant: inset)
        trailingAnchor(equalTo: view.trailingAnchor, constant: -inset)
    }
    
    public func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    public func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    public func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    public func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    public func heightAnchor(equalTo height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    public func widthAnchor(equalTo width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = widthAnchor.constraint(equalToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    public func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) {
        let constraint: NSLayoutConstraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
}
