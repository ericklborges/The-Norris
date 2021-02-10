//
//  BaseUrl.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Foundation

enum BaseUrl {
    private static func getBaseURL(forKey key: String) -> URL {
        let urlString: String = BundleWrapper.value(forKey: key)
        guard let url = URL(string: urlString) else {
            preconditionFailure("Failed to get URL for key: \(key)")
        }
        return url
    }
}

// MARK: - Urls

extension BaseUrl {
    static var chuckNorrisApi: URL {
        return BaseUrl.getBaseURL(forKey: "CHUCK_NORRIS_API_BASE_URL")
    }
}
