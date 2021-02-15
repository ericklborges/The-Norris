//
//  ClientError.swift
//  Network
//
//  Created by erick.lozano.borges on 13/02/21.
//

import Foundation

public struct ClientError: Error {
    public var reason: ClientErrorReason
    public var statusCode: Int
    
    public init(reason: ClientErrorReason, statusCode: Int) {
        self.reason = reason
        self.statusCode = statusCode
    }
}

public enum ClientErrorReason {
    case api(String?)
    case invalidData
    case decoding(Error)
    
    public var description: String {
        switch self {
        case let .api(reason):
            return "Request did fail with reason: \(reason ?? "unknown")"
        case .invalidData:
            return "Request did return invalid data"
        case let .decoding(error):
            return "Request did fail with error: \(error.localizedDescription)"
        }
    }
}

extension ClientErrorReason: Equatable {
    public static func == (lhs: ClientErrorReason, rhs: ClientErrorReason) -> Bool {
        switch (lhs, rhs) {
        case (.api, .api):
            return true
        case (.invalidData, .invalidData):
            return true
        case (.decoding, .decoding):
            return true
        default:
            return false
        }
    }
}
