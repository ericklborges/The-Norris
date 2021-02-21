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
            title: "Thinking",
            message: "Norris brain is processing your request, it won't take long."
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
}

extension FactsListViewModel: FactsListServiceDelegate {
    func didReceive(facts: [Fact]) {
        delegate?.didReceive(facts: facts)
    }
    
    func didReceiveError() {
        delegate?.didReceiveError(
            image: Symbol.clockArrowCirclepath.image(pointSize: 48),
            title: "Something wrong",
            message: "Norris brain could not process your request, try again later.",
            buttonTitle: "Try again"
        )
    }
    
    func didReceiveInvalidQuery() {
        delegate?.didReceiveEmptyResult(
            title: "Invalid search",
            message: "Norris will ignore any search with less than 3 characters. It is a waste of time for him.",
            buttonTitle: "Try again"
        )
    }
    
    func didReceiveEmptyResult() {
        // TODO: menssagem diferente para vazio da primeira vez
        delegate?.didReceiveEmptyResult(
            title: "Nothing found",
            message: "Unfortunatly Norris did not create a word for that. Yet.",
            buttonTitle: "Try again"
        )
    }
}
