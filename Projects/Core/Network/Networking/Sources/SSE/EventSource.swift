//
//  EventSource.swift
//  Finda
//
//  Created by jinseon on 2023/06/27.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

import Alamofire
import Moya
import FindaUtils
import UIKit

public enum EventSourceState {
  case connecting
  case open
  case closed
}
public enum EventSourceError: Error {
  case timeout
}

public protocol EventSourceProtocol {
  var headers: [String: String] { get }
  
  /// Tineout: This is maxium connection time.`
  var timeout: Double { get }
  
  /// URL where EventSource will listen for events.
  var url: URL { get }
  
  /// The last event id received from server. This id is neccesary to keep track of the last event-id received to avoid
  /// receiving duplicate events after a reconnection.
  var lastEventId: String? { get }
  
  /// Current state of EventSource
  var readyState: EventSourceState { get }
  
  /// Method used to connect to server. It can receive an optional lastEventId indicating the Last-Event-ID
  ///
  /// - Parameter lastEventId: optional value that is going to be added on the request header to server.
  func connect(lastEventId: String?)
  
  /// Method used to disconnect from server.
  func disconnect()
  
  /// Returns the list of event names that we are currently listening for.
  ///
  /// - Returns: List of event names.
  func events() -> [String]
  
  /// Callback called when EventSource has successfully connected to the server.
  ///
  /// - Parameter onOpenCallback: callback
  func onOpen(_ onOpenCallback: @escaping (() -> Void))
  
  /// Callback called once EventSource has disconnected from server. This can happen for multiple reasons.
  /// The server could have requested the disconnection or maybe a network layer error, wrong URL or any other
  /// error. The callback receives as parameters the status code of the disconnection, if we should reconnect or not
  /// following event source rules and finally the network layer error if any. All this information is more than
  /// enought for you to take a decition if you should reconnect or not.
  /// - Parameter onOpenCallback: callback
  func onComplete(_ onComplete: @escaping ((Int?, Bool?, Error?) -> Void))
  
  /// This callback is called everytime an event with name "message" or no name is received.
  func onNext(_ onNextCallback: @escaping ((_ id: String?, _ event: String?, _ data: String?) -> Void))
  
  /// Add an event handler for an specific event name.
  ///
  /// - Parameters:
  ///   - event: name of the event to receive
  ///   - handler: this handler will be called everytime an event is received with this event-name
  func addEventListener(_ event: String,
                        handler: @escaping ((_ id: String?, _ event: String?, _ data: String?) -> Void))
  
  /// Remove an event handler for the event-name
  ///
  /// - Parameter event: name of the listener to be remove from event source.
  func removeEventListener(_ event: String)
}

open class EventSource: NSObject, EventSourceProtocol, URLSessionDataDelegate {
  
  public let url: URL
  private(set) public var lastEventId: String?
  private(set) public var timeout: Double = 120.0
  private(set) public var headers: [String: String]
  private(set) public var queryItems: [String: String]
  private(set) public var readyState: EventSourceState
  
  private var onOpenCallback: (() -> Void)?
  private var onComplete: ((Int?, Bool?, Error?) -> Void)?
  private var onNextCallback: ((_ id: String?, _ event: String?, _ data: String?) -> Void)?
  private var eventListeners: [String: (_ id: String?, _ event: String?, _ data: String?) -> Void] = [:]
  
  private var operationQueue: OperationQueue
  private var mainQueue = DispatchQueue.main
  private var urlSession: URLSession?
  private var eventStreamParser: EventStreamParser?
  
  public init(
    target: TargetType,
    headers: [String: String] = [:],
    queryItems: [String: String] = [:]
  ) {
    self.url = target.baseURL.appendingPathComponent(target.path)
    self.headers = headers
    self.queryItems = queryItems
    
    readyState = EventSourceState.closed
    operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
    
    super.init()
  }
  
  public func connect(lastEventId: String? = nil) {
    eventStreamParser = EventStreamParser()
    readyState = .connecting
    
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    let qureis = self.queryItems.map({ URLQueryItem(name: $0.key, value: $0.value) })
    components?.queryItems = qureis
    guard let url = components?.url else {
      return
    }
    
    let configuration = sessionConfiguration(lastEventId: lastEventId)
    urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
    let task = urlSession?.dataTask(with: url)
    task?.resume()
    DispatchQueue.main.asyncAfter(deadline: .now() + timeout) { [weak self] in
      self?.mainQueue.async { [weak self] in
        if self?.readyState != .closed {
          self?.onComplete?(nil, nil, EventSourceError.timeout)
          self?.disconnect()
        }
      }
    }
  }
  
  public func disconnect() {
    readyState = .closed
    urlSession?.invalidateAndCancel()
  }
  
  public func onOpen(_ onOpenCallback: @escaping (() -> Void)) {
    self.onOpenCallback = onOpenCallback
  }
  
  public func onComplete(_ onComplete: @escaping ((Int?, Bool?, Error?) -> Void)) {
    self.onComplete = onComplete
  }
  
  public func onNext(_ onNextCallback: @escaping ((_ id: String?, _ event: String?, _ data: String?) -> Void)) {
    self.onNextCallback = onNextCallback
  }
  
  public func addEventListener(_ event: String,
                               handler: @escaping ((_ id: String?, _ event: String?, _ data: String?) -> Void)) {
    eventListeners[event] = handler
  }
  
  public func removeEventListener(_ event: String) {
    eventListeners.removeValue(forKey: event)
  }
  
  public func events() -> [String] {
    return Array(eventListeners.keys)
  }
  
  open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    
    if readyState != .open {
      return
    }
    if let events = eventStreamParser?.append(data: data) {
      events.forEach { event in
        mainQueue.async { [weak self] in self?.onNextCallback?(event.id, event.event, event.data) }
      }
    }
  }
  
  open func urlSession(_ session: URLSession,
                       dataTask: URLSessionDataTask,
                       didReceive response: URLResponse,
                       completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
    
    completionHandler(URLSession.ResponseDisposition.allow)
    
    readyState = .open
    mainQueue.async { [weak self] in self?.onOpenCallback?() }
  }
  
  open func urlSession(_ session: URLSession,
                       task: URLSessionTask,
                       didCompleteWithError error: Error?) {
    
    guard let responseStatusCode = (task.response as? HTTPURLResponse)?.statusCode else {
      mainQueue.async { [weak self] in self?.onComplete?(nil, nil, error) }
      return
    }
    if let error = error {
      mainQueue.async { [weak self] in self?.onComplete?(nil, nil, error) }
      return
    }
    
    let reconnect = shouldReconnect(statusCode: responseStatusCode)
    mainQueue.async { [weak self] in self?.onComplete?(responseStatusCode, reconnect, nil) }
  }
  
  open func urlSession(_ session: URLSession,
                       task: URLSessionTask,
                       willPerformHTTPRedirection response: HTTPURLResponse,
                       newRequest request: URLRequest,
                       completionHandler: @escaping (URLRequest?) -> Void) {
    
    var newRequest = request
    self.headers.forEach { newRequest.setValue($1, forHTTPHeaderField: $0) }
    completionHandler(newRequest)
  }
}

internal extension EventSource {
  
  func sessionConfiguration(lastEventId: String?) -> URLSessionConfiguration {
    
    var additionalHeaders = headers
    if let eventID = lastEventId {
      additionalHeaders["Last-Event-Id"] = eventID
    }
    
    additionalHeaders["Content-Type"] = "text/event-stream"
    additionalHeaders["Cache-Control"] = "no-cache"
    additionalHeaders["X-Auth-Token"] = UserDefaultManager.shared.userToken ?? ""
    additionalHeaders["X-Client-App-Os-Type"] = OsType.iOS.rawValue
    additionalHeaders["X-Client-App-Version"] = appVersion()
    additionalHeaders["User-Agent"] = HTTPHeaders.default.value(for: "User-Agent")?.replacingOccurrences(of: "핀다", with: "Finda") ?? ""
    let secretKey = parseKeys().secretKey
    var signatureKey: String?
    
    if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
      additionalHeaders["X-Client-Device-Id"] = deviceId
      
      if signatureKey == nil {
        signatureKey = "\(deviceId)\(secretKey)".md5()
      }
      additionalHeaders["X-Signature-V1"] =  signatureKey
    }
    
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.httpAdditionalHeaders = additionalHeaders
    
    return sessionConfiguration
  }
  
  func readyStateOpen() {
    readyState = .open
  }
}

private extension EventSource {
  
  func shouldReconnect(statusCode: Int) -> Bool {
    switch statusCode {
    case 200:
      return false
    case _ where statusCode > 200 && statusCode < 300:
      return true
    default:
      return false
    }
  }
}

public final class EventStreamParser {
  
  //  Events are separated by end of line. End of line can be:
  //  \r = CR (Carriage Return) → Used as a new line character in Mac OS before X
  //  \n = LF (Line Feed) → Used as a new line character in Unix/Mac OS X
  //  \r\n = CR + LF → Used as a new line character in Windows
  private let validNewlineCharacters = ["\r\n", "\n", "\r"]
  private let dataBuffer: NSMutableData
  
  public init() {
    dataBuffer = NSMutableData()
  }
  
  public var currentBuffer: String? {
    return NSString(data: dataBuffer as Data, encoding: String.Encoding.utf8.rawValue) as String?
  }
  
  public func append(data: Data?) -> [Event] {
    guard let data = data else { return [] }
    dataBuffer.append(data)
    
    let events = extractEventsFromBuffer().compactMap { [weak self] eventString -> Event? in
      guard let self = self else { return nil }
      return Event(eventString: eventString, newLineCharacters: self.validNewlineCharacters)
    }
    
    return events
  }
  
  private func extractEventsFromBuffer() -> [String] {
    var events = [String]()
    
    var searchRange =  NSRange(location: 0, length: dataBuffer.length)
    while let foundRange = searchFirstEventDelimiter(in: searchRange) {
      // if we found a delimiter range that means that from the beggining of the buffer
      // until the beggining of the range where the delimiter was found we have an event.
      // The beggining of the event is: searchRange.location
      // The lenght of the event is the position where the foundRange was found.
      
      let dataChunk = dataBuffer.subdata(
        with: NSRange(location: searchRange.location, length: foundRange.location - searchRange.location)
      )
      
      if let text = String(bytes: dataChunk, encoding: .utf8) {
        events.append(text)
      }
      
      // We move the searchRange start position (location) after the fundRange we just found and
      searchRange.location = foundRange.location + foundRange.length
      searchRange.length = dataBuffer.length - searchRange.location
    }
    
    // We empty the piece of the buffer we just search in.
    dataBuffer.replaceBytes(in: NSRange(location: 0, length: searchRange.location), withBytes: nil, length: 0)
    
    return events
  }
  
  // This methods returns the range of the first delimiter found in the buffer. For example:
  // If in the buffer we have: `id: event-id-1\ndata:event-data-first\n\n`
  // This method will return the range for the `\n\n`.
  private func searchFirstEventDelimiter(in range: NSRange) -> NSRange? {
    let delimiters = validNewlineCharacters.map { "\($0)\($0)".data(using: String.Encoding.utf8)! }
    
    for delimiter in delimiters {
      let foundRange = dataBuffer.range(
        of: delimiter, options: NSData.SearchOptions(), in: range
      )
      
      if foundRange.location != NSNotFound {
        return foundRange
      }
    }
    
    return nil
  }
}

public enum Event {
  case event(id: String?, event: String?, data: String?)
  
  public init?(eventString: String?, newLineCharacters: [String]) {
    guard let eventString = eventString else { return nil }
    
    if eventString.hasPrefix(":") {
      return nil
    }
    
    self = Event.parseEvent(eventString, newLineCharacters: newLineCharacters)
  }
  
  public var id: String? {
    guard case let .event(eventId, _, _) = self else { return nil }
    return eventId
  }
  
  public var event: String? {
    guard case let .event(_, eventName, _) = self else { return nil }
    return eventName
  }
  
  public var data: String? {
    guard case let .event(_, _, eventData) = self else { return nil }
    return eventData
  }
  
  public func prettyPrintedData() -> String {
    guard let dataString = self.data else { return "nil" }
    guard let data = dataString.data(using: .utf8) else { return dataString }
    
    do {
      let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
      let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
      return String(data: prettyData, encoding: .utf8) ?? dataString
    } catch {
      return dataString
    }
  }
}

private extension Event {
  
  static func parseEvent(_ eventString: String, newLineCharacters: [String]) -> Event {
    var event: [String: String?] = [:]
    
    for line in eventString.components(separatedBy: CharacterSet.newlines) as [String] {
      let (akey, value) = Event.parseLine(line, newLineCharacters: newLineCharacters)
      guard let key = akey else { continue }
      
      if let value = value, let previousValue = event[key] ?? nil {
        event[key] = "\(previousValue)\n\(value)"
      } else if let value = value {
        event[key] = value
      } else {
        event[key] = nil
      }
    }
    
    // the only possible field names for events are: id, event and data. Everything else is ignored.
    return .event(
      id: event["id"] ?? nil,
      event: event["event"] ?? nil,
      data: event["data"] ?? nil
    )
  }
  
  static func parseLine(_ line: String, newLineCharacters: [String]) -> (key: String?, value: String?) {
    var key: NSString?, value: NSString?
    let scanner = Scanner(string: line)
    scanner.scanUpTo(":", into: &key)
    scanner.scanString(":", into: nil)
    
    for newline in newLineCharacters {
      if scanner.scanUpTo(newline, into: &value) {
        break
      }
    }
    
    // for id and data if they come empty they should return an empty string value.
    if key != "event" && value == nil {
      value = ""
    }
    
    return (key as String?, value as String?)
  }
}
