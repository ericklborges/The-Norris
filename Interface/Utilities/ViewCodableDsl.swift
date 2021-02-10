//
//  ViewCodableDsl.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Foundation

import UIKit

public extension UIView {

    var layout: ViewCodableDsl {
        return ViewCodableDsl(view: self)
    }
}

public class ViewCodableDsl {

    let view: UIView

    init(view: UIView) {
        self.view = view
    }

    public func applyConstraint(_ builder: ((UIView) -> Void)) {
        view.translatesAutoresizingMaskIntoConstraints = false
        builder(view)
    }
}
