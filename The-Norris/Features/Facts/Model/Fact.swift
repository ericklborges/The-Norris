//
//  Fact.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Foundation

struct Fact: Codable {
    let id: String
    let value: String
    let categories: [String]
    let url: String
    
    init(cdFact: CDFact) {
        self.id = cdFact.id
        self.value = cdFact.value
        self.categories = Array(cdFact.categories)
        self.url = cdFact.url
    }
}
