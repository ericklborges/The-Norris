//
//  JsonHelper.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

final class JsonHelper {
    static func getDataFrom<T: Decodable>(json file: String) -> T? {
        guard let path = Bundle(for: JsonHelper.self).path(forResource: file, ofType: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }
}
