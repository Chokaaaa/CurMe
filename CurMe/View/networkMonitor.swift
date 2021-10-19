//
//  networkMonitor.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 06/08/2021.
//

//Code for representation of an error if there is no connection

import Foundation
import Network


final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")


    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }


}
