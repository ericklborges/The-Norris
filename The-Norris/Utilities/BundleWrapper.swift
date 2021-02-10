//
//  BundleWrapper.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Foundation

enum BundleWrapper {

    static func value<Value>(forKey key: String) -> Value {
        let bundle = Bundle.main
        guard let value = bundle.infoDictionary?[key] as? Value else {
            preconditionFailure("Failed to get value of type :\(Value.self), for key: \(key), in bundle: \(bundle)")
        }
        return value
    }
}
