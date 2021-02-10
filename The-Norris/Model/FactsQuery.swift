//
//  FactsQuery.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Foundation

struct FactsQuery: Codable {
    let total: Int
    let result: [Fact]
}
