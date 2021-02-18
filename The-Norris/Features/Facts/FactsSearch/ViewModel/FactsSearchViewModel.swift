//
//  FactsSearchViewModel.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 18/02/21.
//

import Foundation

final class FactsSearchViewModel {
    
    // MARK: - Parameters
    private let categoriesDao: CategoriesDAOProtocol
    private let pastQueryDao: PastQueryDAOProtocol
    
    // MARK: - Init
    init(categoriesDao: CategoriesDAOProtocol = CategoriesDAO.make(), pastQueryDao: PastQueryDAOProtocol = PastQueryDAO.make()) {
        self.categoriesDao = categoriesDao
        self.pastQueryDao = pastQueryDao
    }
    
    // MARK: - Computed Properties
    var categories: [String] {
        guard let categories = categoriesDao.getAll() else { return [] }
        guard categories.count > 10 else { return categories }
        let suffled = categories.shuffled()
        let firstTenSuffled = Array(suffled[0..<10])
        return firstTenSuffled
    }
    
    var pastQueries: [String] {
        return pastQueryDao.getAll() ?? []
    }
    
    // MARK: - Methods
    func save(query: String) {
        pastQueryDao.create(query)
    }
}
