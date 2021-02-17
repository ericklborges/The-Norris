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
    private let categoriesDao: CategoriesDAOProtocol
    weak var delegate: SplashScreenViewModelDelegate?
    
    // MARK: - Init
    init(api: FactsApiProtocol = FactsApi.make(), categoriesDao: CategoriesDAOProtocol = CategoriesDAO.create()) {
        self.api = api
        self.categoriesDao = categoriesDao
    }
}

// MARK: - Requests
extension SplashScreenViewModel {
    func fetchCategories() {
        api.fetchCategories { [weak self] result in
            switch result {
            case let .success(categories):
                self?.categoriesDao.create(categories)
                self?.delegate?.didFinishSetup()
            default:
                return
            }
        }
    }
}
