//
//  FactsListViewModel.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Client
import Foundation
import class UIKit.UIImage
import enum Interface.Symbol

protocol FactsListViewModelDelegate: AnyObject {
    func didReceive(facts: [Fact])
    func didStartLoading(title: String, message: String)
    func didReceiveError(image: UIImage, title: String, message: String, buttonTitle: String)
    func didReceiveEmptyResult(title: String, message: String, buttonTitle: String)
}

final class FactsListViewModel {
    
    // MARK: - Parameters
    private var service: FactsListServiceProtocol
    private var lastQuery: String?
    weak var delegate: FactsListViewModelDelegate?
    
    // MARK: - Init
    init(service: FactsListServiceProtocol = FactsListService()) {
        self.service = service
        self.service.delegate = self
    }
    
    // MARK: - Methods
    func activityItems(for fact: Fact) -> [Any] {
        if let url = URL(string: fact.url) {
            return [url]
        } else {
            return [fact.value]
        }
    }
    
    private func startLoading() {
        delegate?.didStartLoading(
            title: L10n.Loading.title,
            message: L10n.Loading.message
        )
    }
}

// MARK: - Requests

extension FactsListViewModel {
    func fetchFactsRetry() {
        startLoading()
        service.fetchFactsRetry()
    }
    
    func fetchFacts(query: String) {
        startLoading()
        service.fetchFacts(query: query)
    }
    
    func fetchTenRandomfacts() {
        service.fetchTenRandomFacts()
    }
}

// MARK: - FactsListServiceDelegate

extension FactsListViewModel: FactsListServiceDelegate {
    func didReceive(facts: [Fact]) {
        delegate?.didReceive(facts: facts)
    }
    
    func didReceiveError() {
        delegate?.didReceiveError(
            image: Symbol.clockArrowCirclepath.image(pointSize: 48),
            title: L10n.Error.Dafault.title,
            message: L10n.Error.Dafault.message,
            buttonTitle: L10n.Error.Dafault.buttonTitle
        )
    }
    
    func didReceiveInvalidQuery() {
        delegate?.didReceiveEmptyResult(
            title: L10n.Error.InvalidQuery.title,
            message: L10n.Error.InvalidQuery.message,
            buttonTitle: L10n.Error.InvalidQuery.buttonTitle
        )
    }
    
    func didReceiveEmptyResult() {
        delegate?.didReceiveEmptyResult(
            title: L10n.Error.EmptyResult.title,
            message: L10n.Error.EmptyResult.message,
            buttonTitle: L10n.Error.EmptyResult.buttonTitle
        )
    }
    
    func didReceiveDatabaseIsEmpty() {
        delegate?.didReceiveEmptyResult(
            title: L10n.Error.FirstTime.title,
            message: L10n.Error.FirstTime.message,
            buttonTitle: L10n.Error.FirstTime.buttonTitle
        )
    }
    
    func didReceiveEmptyResultFromDatabase() {
        delegate?.didReceiveError(
            image: Symbol.wifiSlash.image(pointSize: 48),
            title: L10n.Error.NoConnection.title,
            message: L10n.Error.NoConnection.message,
            buttonTitle: L10n.Error.NoConnection.buttonTitle
        )
    }
}
