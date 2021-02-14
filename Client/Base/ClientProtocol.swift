//
//  ClientProtocol.swift
//  Network
//
//  Created by erick.lozano.borges on 13/02/21.
//

import Foundation

public typealias HttpHeaders = [String: String]
public typealias HttpParameters = [String: String]

public protocol ClientProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, headers: HttpHeaders, parameters: HttpParameters, completion: @escaping(Result<T, ClientError>) -> Void)
}
