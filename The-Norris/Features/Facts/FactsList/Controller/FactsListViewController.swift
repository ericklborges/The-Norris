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

final class FactsListViewController: StateViewController {
    
    // MARK: - Views
    private lazy var factsView: FactsListView = {
        let view = FactsListView()
        view.shareDelegate = self
        return view
    }()
    
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
    func didReceive(facts: [Fact]) {
        factsView.setup(facts: facts)
        state = .main
    }
    
    func didStartLoading(title: String, message: String) {
        setLoadingState(title: title, message: message)
    }
    
    func didReceiveError(image: UIImage, title: String, message: String, buttonTitle: String) {
        setErrorState(image: image, title: title, message: message, buttonTitle: buttonTitle)
    }
    
    func didReceiveEmptyResult(title: String, message: String, buttonTitle: String) {
        setEmptyState(title: title, message: message, buttonTitle: buttonTitle)
    }
}

// MARK: - FactsListViewShareDelegate

extension FactsListViewController: FactsListViewShareDelegate {
    func factsList(_ view: FactsListView, wantsToShare fact: Fact) {
        let activityItems = viewModel.activityItems(for: fact)
        let activityController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        present(activityController, animated: true)
    }
}

// MARK: - Presentation State

private extension FactsListViewController {
    func setLoadingState(title: String, message: String) {
        state = .loading(title: title, message: message)
    }
    
    func setEmptyState(title: String, message: String, buttonTitle: String) {
        let buttonConfiguration = ButtonConfiguration(title: buttonTitle, action: { [weak self] in
            self?.showSearch()
        })
        
        state = .empty(title: title, message: message, buttonConfiguration: buttonConfiguration)
    }
    
    func setErrorState(image: UIImage, title: String, message: String, buttonTitle: String) {
        let buttonConfiguration = ButtonConfiguration(title: buttonTitle, action: { [weak self] in
            self?.viewModel.fetchFactsRetry()
        })
        
        state = .error(image: image, title: title, message: message, buttonConfiguration: buttonConfiguration)
    }
}
