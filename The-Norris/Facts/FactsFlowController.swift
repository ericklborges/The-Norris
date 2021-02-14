//
//  FactsSearchFlowController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit

class FactsFlowController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = UIViewController()
        controller.view.backgroundColor = .cyan
        install(child: controller)
    }
}
