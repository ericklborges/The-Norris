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
    func didReceiveError()
    func didReceiveEmptyResult()
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
