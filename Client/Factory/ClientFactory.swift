//
//  ClientFactory.swift
//  Network
//
//  Created by erick.lozano.borges on 13/02/21.
//

import Foundation

public enum ClientType {
    case projectClient
}

public enum ClientFactory {
    public static func create(_ type: ClientType = .projectClient) -> ClientProtocol {
        switch type {
        case .projectClient:
            return Client()
        }
    }
}
