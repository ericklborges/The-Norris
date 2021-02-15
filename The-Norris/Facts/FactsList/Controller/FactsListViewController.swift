//
//  FactsListViewController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

protocol FactsListViewControllerFlowDelegate: AnyObject {
    func factsListShowsSearch(_ controller: FactsListViewController)
}

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
    weak var flowDelegate: FactsListViewControllerFlowDelegate?
    
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
        setFirstTimeEmptyState()
    }
    
    override func loadView() {
        view = factsView
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        title = "Facts"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - Navigation
    private func showSearch() {
        flowDelegate?.factsListShowsSearch(self)
    }
    
    // MARK: - Actions
    @objc
    private func searchButtonTap() {
        showSearch()
    }
    
    func fetchFacts(query: String) {
        viewModel.fetchFacts(query: query)
    }
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
    
    func didReceiveEmptyResult() {
        setEmptyState()
    }
    
    func didReceiveError() {
        setErrorState()
    }
}

// MARK: - Presentation State

private extension FactsListViewController {
    func setLoadingState() {
        state = .loading(title: viewModel.loadingTitle, message: viewModel.loadingMessage)
    }
    
    func setFirstTimeEmptyState() {
        let buttonConfiguration = ButtonConfiguration(title: viewModel.firstTimeEmptyButtonTitle, action: { [weak self] in
            self?.showSearch()
        })
        
        state = .empty(
            title: viewModel.firstTimeEmptyTitle,
            message: viewModel.firstTimeEmptyMessage,
            buttonConfiguration: buttonConfiguration
        )
    }
    
    func setEmptyState() {
        let buttonConfiguration = ButtonConfiguration(title: viewModel.buttonTitle, action: { [weak self] in
            self?.showSearch()
        })
        
        state = .empty(
            title: viewModel.emptyTitle,
            message: viewModel.emptyMessage,
            buttonConfiguration: buttonConfiguration
        )
    }
    
    func setErrorState() {
        let buttonConfiguration = ButtonConfiguration(title: viewModel.buttonTitle, action: {})
        
        state = .error(
            image: Symbol.clockArrowCirclepath.image(pointSize: 48),
            title: viewModel.errorTitle,
            message: viewModel.errorMessage,
            buttonConfiguration: buttonConfiguration
        )
    }
}
