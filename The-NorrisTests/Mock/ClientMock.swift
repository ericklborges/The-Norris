//
//  ClientMock.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Client
import Foundation

class ClientMock: ClientProtocol {
    var shouldFail: Bool = false
    var mockFileName: String = ""
    
    private(set) var url: URL?
    private(set) var method: HTTPMethod?
    private(set) var headers: HttpHeaders?
    private(set) var parameters: HttpParameters?
    
    func request<T: Decodable>(url: URL = .stub(), method: HTTPMethod = .get, headers: HttpHeaders = [:], parameters: HttpParameters = [:], completion: @escaping (Result<T, ClientError>) -> Void) {
        
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        
        guard !shouldFail else {
            completion(.failure(ClientError(reason: .api("ClientMock should fail"), statusCode: 999)))
            return
        }
        
        guard let object: T = JsonHelper.getDataFrom(json: mockFileName) else {
            completion(.failure(ClientError(reason: .api("Invalid Json file \"\(mockFileName)\" was not found"), statusCode: 999)))
            return
        }
        
        completion(.success(object))
    }
}
