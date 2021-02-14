//
//  FactsListViewController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit

class FactsListViewController: UIViewController {
    
    // MARK: - Views
    private lazy var searchButton: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTap)
        )
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    // MARK: - Setup
    func setupNavigation() {
        title = "Facts"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - Actions
    @objc
    private func searchButtonTap() {
    }
}
