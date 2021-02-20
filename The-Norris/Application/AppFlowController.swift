//
//  AppFlowController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

final class AppFlowController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplashScreen()
    }
}

// MARK: - Navigation

extension AppFlowController {
    private func showSplashScreen() {
        let controller = SplashScreenViewController()
        controller.flowDelegate = self
        install(child: controller)
    }
    
    private func showFirstViewController() {
        DispatchQueue.main.async { [weak self] in
            self?.switchChild(to: FactsFlowController())
        }
    }
}

// MARK: - SplashScreenFlowDelegate

extension AppFlowController: SplashScreenFlowDelegate {
    func splashScreenDidFinishSetup(_ controller: SplashScreenViewController) {
        showFirstViewController()
    }
}
