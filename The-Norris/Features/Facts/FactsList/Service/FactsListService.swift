//
//  FactsListService.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Client
import Foundation

protocol FactsListServiceDelegate: AnyObject {
    func didReceive(facts: [Fact])
    func didReceiveError()
    func didReceiveEmptyResult()
    func didReceiveInvalidQuery()
}

protocol FactsListServiceProtocol {
    var delegate: FactsListServiceDelegate? { get set }
    func fetchFactsRetry()
    func fetchFacts(query: String)
}

final class FactsListService: FactsListServiceProtocol {
    
    // MARK: - Parameters
    private let api: FactsApiProtocol
    private let dao: FactDAOProtocol
    private var lastQuery: String?
    weak var delegate: FactsListServiceDelegate?
    
    // MARK: - Init
    init(api: FactsApiProtocol = FactsApi.make(), dao: FactDAOProtocol = FactDAO.make()) {
        self.api = api
        self.dao = dao
    }

    // MARK: - Methods
    func fetchFactsRetry() {
        guard let query = lastQuery else { return }
        apiFetchFacts(query: query)
    }
    
    func fetchFacts(query: String) {
        apiFetchFacts(query: query)
    }
}

// MARK: - Database
extension FactsListService {
    private func save(_ facts: [Fact], for query: String) {
        facts.forEach { dao.create($0, for: query) }
    }
}

// MARK: - Network
extension FactsListService {
    private func apiFetchFacts(query: String) {
        lastQuery = query
        api.fetchFacts(query: query) { [weak self] result in
            switch result {
            case let .success(factsQuery):
                self?.handleFetchFactsSuccess(factsQuery, for: query)
            case let .failure(error):
                self?.handleFetchFactsError(error)
            }
        }
    }
    
    private func handleFetchFactsSuccess(_ factsQuery: FactsQuery, for query: String) {
        guard factsQuery.total > 0 else {
            delegate?.didReceiveEmptyResult()
            return
        }
        save(factsQuery.result, for: query)
        delegate?.didReceive(facts: factsQuery.result)
    }
    
    private func handleFetchFactsError(_ error: ClientError) {
        guard error.statusCode != 400 else {
            delegate?.didReceiveInvalidQuery()
            return
        }
        delegate?.didReceiveError()
    }
}
