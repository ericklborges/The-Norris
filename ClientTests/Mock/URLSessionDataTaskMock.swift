//
//  URLSessionDataTaskMock.swift
//  ClientTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Foundation

final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
