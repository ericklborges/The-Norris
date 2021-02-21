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
        searchbar.placeholder = L10n.FactsSearch.Searchbar.placeholder
        return searchbar
    }()
    
    private lazy var factsSearchView: FactsSearchView = {
        let view = FactsSearchView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    private let viewModel: FactsSearchViewModel
    private var scrollViewContentInset: UIEdgeInsets = .zero
    weak var flowDelegate: FactsSearchViewControllerFlowDelegate?
    
    // MARK: - Life Cycle
    init(viewModel: FactsSearchViewModel = FactsSearchViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addKeyboardShowNotification()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupFactsSearchView()
    }
    
    override func loadView() {
        view = factsSearchView
    }
    
    // MARK: - Setup
    private func addKeyboardShowNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    private func setupFactsSearchView() {
        let categories = viewModel.categories
        factsSearchView.setup(categories: categories)
        
        let pastQueries = viewModel.pastQueries
        factsSearchView.setup(pastQueries: pastQueries)
    }
    
    // MARK: - Actions
    @objc
    private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        scrollViewContentInset.bottom = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
    }
    
    private func endSearch(with query: String) {
        viewModel.save(query: query)
        flowDelegate?.factsSearch(self, didEndWith: query)
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
        endSearch(with: textField.text ?? "")
        return true
    }
}

// MARK: - FactsSearchViewDelegate

extension FactsSearchViewController: FactsSearchViewDelegate {
    func didSelectSuggestion(_ query: String) {
        endSearch(with: query)
    }
    
    func contentInset() -> UIEdgeInsets {
        return scrollViewContentInset
    }
}
