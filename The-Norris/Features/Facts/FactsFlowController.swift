//
//  FactsFlowController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

class FactsFlowController: UIViewController {
    
    // MARK: - Parameters
    private lazy var navigation = UINavigationController()
    private var searchEndAction: ((String) -> Void)?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        showFirstController()
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        navigation.applyCustomAppearence()
        install(child: navigation)
    }
}

// MARK: - Navigation

extension FactsFlowController {
    private func showFirstController() {
        let controller = FactsListViewController()
        controller.flowDelegate = self
        searchEndAction = controller.fetchFacts(query:)
        navigation.show(controller, sender: nil)
    }
    
    private func showSearchController() {
        let controller = FactsSearchViewController()
        let navigation = UINavigationController(rootViewController: controller)
        controller.flowDelegate = self
        present(navigation, animated: true, completion: nil)
    }
}

// MARK: - FactsListViewControllerFlowDelegate

extension FactsFlowController: FactsListViewControllerFlowDelegate {
    func factsListShowsSearch(_ controller: FactsListViewController) {
        showSearchController()
    }
}

// MARK: - FactsSearchViewControllerFlowDelegate

extension FactsFlowController: FactsSearchViewControllerFlowDelegate {
    func factsSearch(_ controller: FactsSearchViewController, didEndWith query: String) {
        searchEndAction?(query)
        controller.dismiss(animated: true, completion: nil)
    }
}
