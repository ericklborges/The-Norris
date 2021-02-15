//
//  FactsListViewModel.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

protocol FactsListViewModelDelegate: AnyObject {
    func didChange(facts: [Fact])
    func didStartRequest()
    func didReceiveEmptyResult()
    func didReceiveError()
}

class FactsListViewModel {
    
    // MARK: - Parameters
    private let api: FactsApiProtocol
    private var factsQuery: FactsQuery?
    weak var delegate: FactsListViewModelDelegate?
    
    // MARK: - Init
    init(api: FactsApiProtocol = FactsApi.make()) {
        self.api = api
    }
    
    // MARK: - Computed Properties
    
    // MARK: Button
    var buttonTitle: String {
        return "Try again"
    }
    
    // MARK: Loading
    var loadingTitle: String {
        return "Thinking"
    }
    
    var loadingMessage: String {
        return "Norris brain is processing your request, it won't take long."
    }
    
    // MARK: Empty
    var emptyTitle: String {
        return "Nothing found"
    }
    
    var emptyMessage: String {
        return "Unfortunatly Norris did not create a word for that. Yet."
    }
    
    // MARK: Error
    var errorTitle: String {
        return "Something wrong"
    }
    
    var errorMessage: String {
        return "Norris brain could not process yout request, try again later."
    }
}

// MARK: - Requests
extension FactsListViewModel {
    func fetchFacts(query: String) {
        delegate?.didStartRequest()
        api.fetchFacts(query: query) { [weak self] result in
            switch result {
            case let .success(factsQuery):
                self?.handleFetchFactsSuccess(factsQuery)
            case .failure:
                self?.delegate?.didReceiveError()
            }
        }
    }
    
    func handleFetchFactsSuccess(_ factsQuery: FactsQuery) {
        self.factsQuery = factsQuery
        
        if factsQuery.result.isEmpty {
            delegate?.didReceiveEmptyResult()
            return
        }

        delegate?.didChange(facts: factsQuery.result)
    }
}
