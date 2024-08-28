//
//  HomeAPI.swift
//  FindaAPIs
//
//  Created by 김효성 on 4/14/24.
//  Copyright © 2024 Finda. All rights reserved.
//

import Foundation
import Moya

public enum HomeAPI: BaseAPI {
  /// 홈 자산 정보 조회 API
  case assetsInfo
}

extension HomeAPI {
  public var method: Moya.Method {
    switch self {
    case .assetsInfo: return .get
    }
  }
}

extension HomeAPI {
  public var task: Task {
    switch self {
    case .assetsInfo: return .requestPlain
    }
  }
}

extension HomeAPI {
  public var baseURL: URL {
    guard let url = URL(string: greenURL()) else { fatalError("Bad Request baseURL")}
    return url
  }
}

extension HomeAPI {
  public var path: String {
    switch self {
    case .assetsInfo:
      return "/ams/v1/home/assets-info"
    }
  }
}
