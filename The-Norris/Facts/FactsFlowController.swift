//
//  FactsSearchFlowController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

class FactsFlowController: UIViewController {
    
    private let navigation = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.applyCustomAppearence()
        navigation.show(FactsListViewController(), sender: nil)
        install(child: navigation)
    }
}
