//
//  FactsListViewController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

class FactsListViewController: StateViewController {
    
    // MARK: - Views
    private let factsView = FactsListView()
    
    private lazy var searchButton: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTap)
        )
    }()
    
    // MARK: - Properties
    private let viewModel: FactsListViewModel
    
    // MARK: - Life Cycle
    init(viewModel: FactsListViewModel = FactsListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        viewModel.delegate = self
    }
    
    override func loadView() {
        view = factsView
    }
    
    // MARK: - Setup
    func setupNavigation() {
        title = "Facts"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - Actions
    @objc
    private func searchButtonTap() { }
}

// MARK: - FactsListViewModelDelegate

extension FactsListViewController: FactsListViewModelDelegate {
    func didChange(facts: [Fact]) {
        factsView.setup(facts: facts)
        state = .main
    }
    
    func didStartRequest() {
        setLoadingState()
    }
    
    func didReceiveError() {
        setErrorState()
    }
    
    func didReceiveEmptyResult() {
        seteEmptyState()
    }
}

// MARK: - Presentation State

private extension FactsListViewController {
    func setLoadingState() {
        state = .loading(title: "Thinking", message: "Norris brain is processing your request, it won't take long.")
    }
    
    func setErrorState() {
        let buttonConfiguration = ButtonConfiguration(title: "Try Again", action: { [weak self] in
            self?.searchButtonTap()
        })
        
        state = .error(
            image: Symbol.clockArrowCirclepath.image(pointSize: 48),
            title: "Something wrong",
            message: "Norris brain could not process yout request, try again later.",
            buttonConfiguration: buttonConfiguration
        )
    }
    
    func seteEmptyState() {
        let buttonConfiguration = ButtonConfiguration(title: "Try Again", action: { [weak self] in
            self?.searchButtonTap()
        })
        
        state = .empty(
            title: "Nothing found",
            message: "Unfortunatly Norris did not create a word for that. Yet.",
            buttonConfiguration: buttonConfiguration
        )
    }
}
