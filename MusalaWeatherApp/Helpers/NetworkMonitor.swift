//
//  NetworkMonitor.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/13/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Network

/// Singleton Monitor for Network Connectivity (Reachability)
class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()

    private init() {
        handler()
        start()
    }

    private func handler() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                debugPrint("Connection OK")
            } else {
                debugPrint("No connection.")
            }
        }
    }

    func start() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    func isConnected() -> Bool {
        debugPrint(monitor.currentPath.status)
        return monitor.currentPath.status == .satisfied
    }
}

