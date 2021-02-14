//
//  HTTPURLResponse+Stub.swift
//  ClientTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Foundation

extension HTTPURLResponse {
    static func stub(url: URL = .stub(), statusCode: Int = 200) -> HTTPURLResponse? {
        return HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
    }
}
