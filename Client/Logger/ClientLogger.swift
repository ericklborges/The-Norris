//
//  RequestLogger.swift
//  Client
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Foundation

final class RequestLogger {
    
    enum LogLevel {
        case none
        case debug
    }
    
    private let loglevel: LogLevel

    required init(level: LogLevel) {
        loglevel = level
    }
}

extension RequestLogger {
    func log(request: URLRequest) {
        guard loglevel != .none else { return }
        guard let method = request.httpMethod, let url = request.url else { return }
        
        printSeparator()
        log(method: method, url: url.absoluteString)
        log(headers: request.allHTTPHeaderFields)
        log(body: request.httpBody)
    }
    
    func log(response: HTTPURLResponse, data: Data?) {
        guard loglevel != .none else { return }
        guard let url = response.url else { return }
        
        printSeparator()
        log(statusCode: response.statusCode, url: url.absoluteString)
        log(headers: response.allHeaderFields)
        log(body: data)
    }
    
    func log(error: ClientError, request: URLRequest) {
        guard loglevel != .none else { return }
        guard let url = request.url else { return }
        
        printSeparator()
        printTagged("[Error] \(error.statusCode) '\(url)':")
        printTagged("Reason: \(error.reason)")
        printTagged("Description: \(error.reason.description)")
    }
}

private extension RequestLogger {
    func printSeparator() {
        printTagged("---------------------------------------------------------------------------")
    }
    
    func printTagged(_ string: String) {
        print("[Client] \(string)")
    }
    
    func log(body: Data?) {
        guard
            let data = body,
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let prettyString = String(data: prettyData, encoding: .utf8)
        else {
            printTagged("Body: {}")
            return
        }
        
        let components = prettyString.components(separatedBy: "\n")
        printTagged("Body: {")
        components.forEach { printTagged("\t\($0)") }
        printTagged("}")
    }
    
    // MARK: - Request
    func log(method: String, url: String) {
        printTagged("\(method) '\(url)':")
    }
    
    func log(headers: HttpHeaders?) {
        guard let headers = headers, !headers.isEmpty else {
            printTagged("Headers: []")
            return
        }

        printTagged("Headers: [")
        headers.forEach { printTagged("\t\($0): \($1)") }
        printTagged("]")

    }
    
    // MARK: - Response
    func log(statusCode: Int, url: String) {
        printTagged("\(statusCode) '\(url)':")
    }
    
    func log(headers: [AnyHashable: Any]) {
        if headers.isEmpty {
            printTagged("Headers: []")
            return
        }
        
        printTagged("Headers: [")
        headers.forEach { printTagged("\t\($0): \($1)") }
        printTagged("]")

    }
}
