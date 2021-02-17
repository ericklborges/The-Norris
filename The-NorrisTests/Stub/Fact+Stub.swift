//
//  Fact+Stub.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

@testable import The_Norris

extension Fact {
    static func stub(id: String = "0", value: String = "value", categories: [String] = ["category"], url: String = "") -> Fact {
        return Fact(id: id, value: value, categories: categories, url: url)
    }
}

extension Sequence where Element == Fact {
    static func stub() -> [Fact] {
        return [
            .stub(id: "0", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit ae.", categories: ["Category 1"]),
            .stub(id: "1", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.", categories: []),
            .stub(id: "2", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit ae.", categories: ["Category 3"]),
            .stub(id: "3", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.", categories: ["Category 4"]),
            .stub(id: "4", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit ae.", categories: [])
        ]
    }
}
