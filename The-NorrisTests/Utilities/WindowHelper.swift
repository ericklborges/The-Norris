//
//  WindowHelper.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 13/02/21.
//

import UIKit

class WindowHelper {
    
    static var testWindow = UIWindow(frame: UIScreen.main.bounds)
    
    static func showInTestWindow(_ controller: UIViewController) {
        WindowHelper.testWindow.rootViewController = controller
        WindowHelper.testWindow.makeKeyAndVisible()
    }
    
    static func cleanTestWindow() {
        WindowHelper.testWindow.rootViewController = nil
        WindowHelper.testWindow.isHidden = true
    }
}
