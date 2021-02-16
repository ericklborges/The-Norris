//
//  UIViewController+Childs.swift
//  Interface
//
//  Created by erick.lozano.borges on 13/02/21.
//

import UIKit

public extension UIViewController {
    
    func switchChild(to newController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let currentController = self.children.last {
                self.remove(child: currentController)
            }
            self.install(child: newController)
        }
    }
    
    func install(child: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.addChild(child)
            self.view.addSubview(child.view)
            
            child.view.layout.applyConstraint { make in
                make.constrainEdges(to: self.view)
            }
            
            child.didMove(toParent: self)
        }
    }
    
    func remove(child: UIViewController) {
        DispatchQueue.main.async {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
