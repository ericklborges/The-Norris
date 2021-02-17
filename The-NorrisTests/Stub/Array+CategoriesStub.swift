//
//  Array+CategoriesStub.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 17/02/21.
//

import Foundation

extension Sequence where Element == String {
    static func categoriesStub() -> [String] {
        return [
            "explicit",
            "fashion",
            "food",
            "history",
            "money",
            "movie",
            "music",
            "political",
            "religion",
            "science"
        ]
    }
}
