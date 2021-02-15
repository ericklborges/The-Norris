//
//  AppFlowController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

class AppFlowController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        install(child: FactsFlowController())
    }
}
