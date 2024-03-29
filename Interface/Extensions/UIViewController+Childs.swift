//
//  UIViewController+Childs.swift
//  Interface
//
//  Created by erick.lozano.borges on 13/02/21.
//

import UIKit

public extension UIViewController {
    
    func switchChild(to newController: UIViewController) {
        if let currentController = children.last {
            remove(child: currentController)
        }
        install(child: newController)
    }
    
    func install(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        
        child.view.layout.applyConstraint { make in
            make.constrainEdges(to: view)
        }
        
        child.didMove(toParent: self)
        
    }
    
    func remove(child: UIViewController) {
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
