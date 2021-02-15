//
//  UINavigationController+Appearence.swift
//  Interface
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit

public extension UINavigationController {
    func applyCustomAppearence() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Color.Text.primary]
        navBarAppearance.titleTextAttributes = [.foregroundColor: Color.Text.primary]
        navBarAppearance.backgroundColor = Color.Background.main
        
        navigationBar.compactAppearance = navBarAppearance
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true
    }
}
