//
//  NetworkMonitor.swift
//  Networking
//
//  Created by woochan on 6/28/24.
//  Copyright © 2024 Finda. All rights reserved.
//

import Foundation
import Network

public protocol NetworkMonitorDelegate: NSObject {
  func statusChanged(_ status: NWPath.Status)
}

final public class NetworkMonitor {
  private let queue = DispatchQueue.global(qos: .background)
  private let monitor: NWPathMonitor
  private var lastStatus: NWPath.Status?
  public weak var delegate: (any NetworkMonitorDelegate)?
  
  public init() {
    monitor = NWPathMonitor()
  }
  
  public func startMonitoring() {
    monitor.pathUpdateHandler = { [weak self] path in
      guard let self else { return }
      guard self.lastStatus != path.status else { return }
      self.lastStatus = path.status
      self.delegate?.statusChanged(path.status)
    }
    monitor.start(queue: queue)
  }
  
  public func stopMonitoring() {
    monitor.cancel()
  }
}
