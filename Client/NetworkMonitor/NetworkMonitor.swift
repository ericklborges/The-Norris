//
//  NetworkMonitor.swift
//  Client
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Network

public class NetworkMonitor {
    
    // MARK: - Singleton
    public static let shared = NetworkMonitor()
    
    private init() { }
    
    // MARK: - Properties
    private let monitor = NWPathMonitor()
    private var currentStatus: NWPath.Status = .requiresConnection
    
    var testsIsReachable: () -> Bool = { true }
    
    public var isReachable: Bool {
        #if TESTS
        return testsIsReachable()
        #else
        return currentStatus == .satisfied
        #endif
    }
    
    // MARK: - Methods
    public func startMonitoring() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { [weak self] path in
            self?.currentStatus = path.status
        }
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}
