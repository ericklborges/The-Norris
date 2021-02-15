//
//  FactsEndpoint.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

enum FactsEndpoint {
    case search(query: String)
    
    private var baseUrl: URL {
        return BaseUrl.chuckNorrisApi
    }
    
    private var path: String {
        switch self {
        case .search:
            return "/jokes/search"
        }
    }

    var url: URL {
        var urlComponents = URLComponents(string: baseUrl.absoluteString)
        urlComponents?.path = path
        urlComponents?.queryItems = []
        
        switch self {
        case let .search(query):
            urlComponents?.queryItems?.append(URLQueryItem(name: "query", value: query))
        }
        
        return urlComponents?.url ?? URL(string: "https://")!
    }
}
