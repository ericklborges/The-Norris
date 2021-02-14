//
//  Client.swift
//  Network
//
//  Created by erick.lozano.borges on 13/02/21.
//

import Foundation

final class Client {
    
    private let session: URLSession
    private var logger = RequestLogger(level: .debug)
    
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
        
        logger.log(request: request)
        
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                let unknownStatusCode = 666
                let clientError = ClientError(reason: .api(error?.localizedDescription), statusCode: unknownStatusCode)
                self.logger.log(error: clientError, request: request)
                completion(.failure(clientError))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            guard let data = data else {
                let clientError = ClientError(reason: .invalidData, statusCode: statusCode)
                self.logger.log(error: clientError, request: request)
                completion(.failure(clientError))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                self.logger.log(response: httpResponse, data: data)
                completion(.success(object))
            } catch let error {
                let clientError = ClientError(reason: .decoding(error), statusCode: statusCode)
                self.logger.log(error: clientError, request: request)
                completion(.failure(clientError))
            }
        }.resume()
    }
}
