//
//  FactsQuery+Stub.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

@testable import The_Norris

extension FactsQuery {
    static func stub(total: Int = 0, result: [Fact] = .stub()) -> FactsQuery {
        return FactsQuery(total: total, result: result)
    }
}
