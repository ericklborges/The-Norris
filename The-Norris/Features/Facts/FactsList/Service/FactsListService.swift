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
    func didReceiveDatabaseIsEmpty()
    func didReceiveEmptyResultFromDatabase()
}

protocol FactsListServiceProtocol {
    var delegate: FactsListServiceDelegate? { get set }
    func fetchFactsRetry()
    func fetchFacts(query: String)
    func fetchTenRandomFacts()
}

final class FactsListService: FactsListServiceProtocol {
    
    // MARK: - Parameters
    private let api: FactsApiProtocol
    private let dao: FactDAOProtocol
    private var lastQuery: String?
    weak var delegate: FactsListServiceDelegate?
    
    // MARK: - Computed Properties
    private var isReachable: Bool {
        return NetworkMonitor.shared.isReachable
    }
    
    // MARK: - Init
    init(api: FactsApiProtocol = FactsApi.make(), dao: FactDAOProtocol = FactDAO.make()) {
        self.api = api
        self.dao = dao
    }

    // MARK: - Methods
    func fetchFactsRetry() {
        guard let query = lastQuery else { return }
        fetchFacts(query: query)
    }

    func fetchFacts(query: String) {
        lastQuery = query
        if isReachable {
            apiFetchFacts(query: query)
        } else {
            daoFetchFacts(query: query)
        }
    }
    
    func fetchTenRandomFacts() {
        daoFetchTenRandomFacts()
    }
}

// MARK: - Database
extension FactsListService {
    private func save(_ facts: [Fact], for query: String) {
        facts.forEach { dao.create($0, for: query) }
    }
    
    private func daoFetchFacts(query: String) {
        guard let facts = dao.getAll(for: query) else {
            delegate?.didReceiveEmptyResultFromDatabase()
            return
        }
        delegate?.didReceive(facts: facts)
    }
    
    private func daoFetchTenRandomFacts() {
        guard let facts = dao.getAll() else {
            delegate?.didReceiveDatabaseIsEmpty()
            return
        }
        
        guard facts.count > 10 else {
            delegate?.didReceive(facts: facts)
            return
        }

        let suffled = facts.shuffled()
        let firstTenSuffled = Array(suffled[0..<10])
        delegate?.didReceive(facts: firstTenSuffled)
    }
}

// MARK: - Network
extension FactsListService {
    private func apiFetchFacts(query: String) {
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
