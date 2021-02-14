//
//  Client.swift
//  Network
//
//  Created by erick.lozano.borges on 13/02/21.
//

import Foundation

final class Client {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - ClientProtocol

extension Client: ClientProtocol {
    public func request<T: Decodable>(url: URL, method: HTTPMethod, headers: HttpHeaders = [:], parameters: HttpParameters = [:], completion: @escaping (Result<T, ClientError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                let unknownStatusCode = 666
                completion(.failure(ClientError(reason: .api(error?.localizedDescription), statusCode: unknownStatusCode)))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            guard let data = data else {
                completion(.failure(ClientError(reason: .invalidData, statusCode: statusCode)))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let error {
                completion(.failure(ClientError(reason: .decoding(error), statusCode: statusCode)))
            }
        }.resume()
    }
}
