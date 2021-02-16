//
//  FactsEndpoint.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Foundation

enum FactsEndpoint {
    case categories
    case search(query: String)
    
    private var baseUrl: URL {
        return BaseUrl.chuckNorrisApi
    }
    
    private var path: String {
        switch self {
        case .categories:
            return "/jokes/categories"
        case .search:
            return "/jokes/search"
        }
    }

    private var queryItems: [URLQueryItem]? {
        switch self {
        case let .search(query):
            return [URLQueryItem(name: "query", value: query)]
        default:
            return nil
        }
    }
    
    var url: URL {
        var urlComponents = URLComponents(string: baseUrl.absoluteString)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            preconditionFailure("The url has not been built correctly")
        }
        
        return url
    }
}
