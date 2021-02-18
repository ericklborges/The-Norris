//
//  FactsSearchViewController.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

protocol FactsSearchViewControllerFlowDelegate: AnyObject {
    func factsSearch(_ controller: FactsSearchViewController, didEndWith query: String)
}

final class FactsSearchViewController: UIViewController {
    
    // MARK: - Views
    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.delegate = self
        searchbar.searchTextField.delegate = self
        searchbar.showsCancelButton = true
        searchbar.placeholder = "search for a fact"
        return searchbar
    }()
    
    private lazy var factsSearchView: FactsSearchView = {
        let view = FactsSearchView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    private let viewModel: FactsSearchViewModel
    weak var flowDelegate: FactsSearchViewControllerFlowDelegate?
    
    // MARK: - Life Cycle
    init(viewModel: FactsSearchViewModel = FactsSearchViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupKeyboardHideGesture()
        setupFactsSearchView()
    }
    
    override func loadView() {
        view = factsSearchView
    }
    
    // MARK: - Setup
    private func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    private func setupKeyboardHideGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupFactsSearchView() {
        let categories = viewModel.categories
        factsSearchView.setup(categories: categories)
    }
    
    // MARK: - Actions
    @objc
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate

extension FactsSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension FactsSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        flowDelegate?.factsSearch(self, didEndWith: textField.text ?? "")
        return true
    }
}

// MARK: - FactsSearchViewDelegate

extension FactsSearchViewController: FactsSearchViewDelegate {
    func didSelectSuggestion(_ query: String) {
        flowDelegate?.factsSearch(self, didEndWith: query)
    }
}
