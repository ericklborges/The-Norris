//
//  URLSessionMock.swift
//  ClientTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Foundation

final class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    var passedRequest: URLRequest?
    var response: HTTPURLResponse? = .stub()
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        passedRequest = request
        return URLSessionDataTaskMock { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        }
    }
}
