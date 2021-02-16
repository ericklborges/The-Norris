//
//  AppViewModel.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

protocol SplashScreenViewModelDelegate: AnyObject {
    func didFinishSetup()
}

class SplashScreenViewModel {
    
    // MARK: - Parameters
    private let api: FactsApiProtocol
    weak var delegate: SplashScreenViewModelDelegate?
    
    // MARK: - Init
    init(api: FactsApiProtocol = FactsApi.make()) {
        self.api = api
    }
}

// MARK: - Requests
extension SplashScreenViewModel {
    func fetchCategories() {
        api.fetchCategories { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didFinishSetup()
            case .failure:
                return
            }
        }
    }
}
