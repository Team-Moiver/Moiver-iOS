//
//  SSENetworkingProtocol.swift
//  Finda
//
//  Created by jinseon on 2023/07/03.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

import Moya
import RxSwift

public enum SSENetworkingError: Error {
  case timeout
  case empty
  case error(_: Error)
}

public enum SSENetworkingType {
  case card
}

public protocol SSENetworkingProtocol: AnyObject {
  func request<T>(target: TargetType,
                  type: T.Type,
                  queryItems: [String: String]) -> Observable<T> where T: Decodable
  func disconnectAllEventSources()
  func disconnectEventSource(for target: TargetType)
}

public final class SSENetworking: SSENetworkingProtocol {
  public static let shared = SSENetworking()
  private var activeEventSources: [String: EventSource] = [:]
  
  public func request<T>(target: TargetType,
                           type: T.Type,
                           queryItems: [String: String]) -> Observable<T> where T: Decodable {
    return Observable.create { observer in
      if self.activeEventSources.contains(where: { $0.key == target.path }) {
        observer.onError(SSENetworkingError.empty)
      }
      let eventSource = EventSource(target: target, queryItems: queryItems)
      eventSource.connect()
      self.activeEventSources[target.path] = eventSource
      
      eventSource.onNext { _, event, data in
        if let eventData = data?.data(using: .utf8) {
          do {
            let decodedData = try JSONDecoder().decode(T.self, from: eventData)
            observer.onNext(decodedData)
          } catch {
            /// JSON 형태가 아닌 데이터는 무시
            if let event = event {
              print(String(describing: error))
            } else {
              print(error)
            }
          }
        } else {
          observer.onError(SSENetworkingError.empty)
        }
      }
      eventSource.onComplete { _, _, error in
        if eventSource.readyState != .closed {
          eventSource.disconnect()
        }
        if let error = error as? EventSourceError {
          switch error {
          case .timeout:
            observer.onError(SSENetworkingError.timeout)
          }
        } else if let error = error {
          observer.onError(SSENetworkingError.error(error))
        }
        self.activeEventSources.removeValue(forKey: target.path)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  public func disconnectAllEventSources() {
    for (_, eventSource) in activeEventSources {
      eventSource.disconnect()
    }
    activeEventSources.removeAll()
  }
  
  public func disconnectEventSource(for target: TargetType) {
    if let eventSource = activeEventSources[target.path] {
      eventSource.disconnect()
      activeEventSources.removeValue(forKey: target.path)
    }
  }
}

