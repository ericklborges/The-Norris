//
//  SceneDelegate.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 08/02/21.
//

import UIKit
import Interface

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        #if !TESTS
        window = UIWindow(windowScene: scene)
        window?.rootViewController = AppFlowController()
        window?.makeKeyAndVisible()
        #endif
    }
}
