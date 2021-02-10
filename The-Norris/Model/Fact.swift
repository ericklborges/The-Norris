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
    let createdAt: String
    let iconURL: String
    let updatedAt: String
    let url: String
}
