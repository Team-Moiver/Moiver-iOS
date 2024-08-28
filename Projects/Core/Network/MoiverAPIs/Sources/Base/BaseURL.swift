//
//  BaseURL.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/11.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

func baseUrl() -> String {
    guard let url = Bundle.main.infoDictionary?["AppServerURL"] as? String
    else { fatalError("Invalid Server URL") }
    return url
}

func greenURL() -> String {
  guard let url = Bundle.main.infoDictionary?["AppGreenURL"] as? String
  else { fatalError("Invalid Server URL") }
  return url
}

public func webUrl() -> String {
    guard let url = Bundle.main.infoDictionary?["WebServerURL"] as? String
    else { fatalError("Invalid Web URL") }
    return url
}

func incidentUrl() -> String {
    guard let url = Bundle.main.infoDictionary?["IncidentServerURL"] as? String
    else { fatalError("Invalid IncidentServerURL ") }
    return url
}

public func autoWebUrl() -> String {
  guard let url = Bundle.main.infoDictionary?["AutoWebServerURL"] as? String
  else { fatalError("Invalid Web URL") }
  return url
}
