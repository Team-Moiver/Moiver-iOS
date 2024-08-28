//
//  AccountAPI.swift
//  Finda
//
//  Created by 엄기철 on 2021/04/28.
//  Copyright © 2021 Finda. All rights reserved.
//

import Moya
import ObjectMapper
import Alamofire
import FindaUtils

public enum AccountAPI {
  case userRegist(UserRegisterRequest)
  case userInfo
  case userLogin(param: UserLoginRequest)
  case rentalGuide
  case pincodeUserUpdate(PincodeUpdateRequest)
  case userUpdate(param: AccountUserInfoUpdateRequest)
  case channelTalkHashing(param: ChannelIoMemberRequest)
  case terms(params: TermsParams?)
  case deleteKcbData(param: Int)
  case deleteUser(param: Int)
  case externalIdRegist(param: String)
  case updateAppInstanceId(UpdateAnalyticsDTO)
  case inspection
  case operationPropertyBanner
  case operationPropertyBottomSheet
  // 알림 세분화 API
  case userAlarm
  case userAlarmByScene(param: AccountUserAlarmParam)
  case userAlarmUpdate(request: AccountUserAlarmUpdateRequest)
  
  // 더보기 메뉴
  case moreMenu
  
  /// 수집이용동의 API
  case agreementFalse
  case postTerms([PostTerm])
}

extension AccountAPI: BaseAPI {
  
  public var baseURL: URL {
    guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
    return url
  }
  
  public var path: String {
    switch self {
    case .userRegist:
      return "account/v4/user"
    case .userLogin:
      return "account/v4/user/login"
    case .userInfo, .userUpdate:
      return "/account/v4/user/info"
    case .rentalGuide:
      return "/hl/v1/guide"
    case .channelTalkHashing:
      return "misc/v1/tools/data-encipher/channel-talk"
    case .terms:
      return "/account/v1/terms"
    case .deleteKcbData(let userId):
      return "/pf/v2/personalcredit/kcb-data/user/\(userId)"
    case .deleteUser(let userId):
      return "/account/v1/user/\(userId)"
    case .externalIdRegist(let externalType):
      return "/account/v4/user/external-id/\(externalType)"
    case .pincodeUserUpdate:
      return "/account/v4/user/pincode"
    case .updateAppInstanceId:
      return "/account/v4/user/ga4"
    case .userAlarm:
      return "/account/v4/alarm"
    case .userAlarmByScene(let param):
      return "/account/v4/alarm/used-category/\(param.alarmUsedCategory)"
    case .userAlarmUpdate:
      return "/account/v4/alarm/alarm-type"
    case .inspection:
      return "account/v1/operation-property"
    case .operationPropertyBanner:
      return "/frm/v1/ui/banner/HOME"
    case .operationPropertyBottomSheet:
      return "/frm/v1/ui/bottom-sheet/HOME"
    case .moreMenu:
      return "/pcs/more-menu/v1/iOS"
    case .agreementFalse:
      return "/account/v4/user/agreement/false"
    case .postTerms:
      return "/account/v4/user/terms"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .userInfo, .terms, .externalIdRegist, .userAlarm, .userAlarmByScene, .inspection, .operationPropertyBanner, .operationPropertyBottomSheet, .moreMenu, .agreementFalse:
      return .get
    case .userRegist, .userLogin, .channelTalkHashing, .postTerms:
      return .post
    case .userUpdate, .pincodeUserUpdate, .updateAppInstanceId, .userAlarmUpdate:
      return .put
    case .rentalGuide, .deleteKcbData, .deleteUser:
      return .delete
    }
  }
  
  public var task: Task {
    guard let parameters = parameters else { return .requestPlain }
    switch self {
    case .userInfo, .deleteKcbData, .deleteUser, .externalIdRegist, .userAlarm, .userAlarmByScene, .moreMenu, .operationPropertyBanner, .operationPropertyBottomSheet, .agreementFalse:
      return .requestPlain
    case .userAlarmUpdate(let request):
      return .requestJSONEncodable(request)
    case .userLogin(let param):
      return .requestJSONEncodable(param)
    case .rentalGuide, .terms, .inspection:
      return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    case let .userUpdate(param):
      return .requestJSONEncodable(param)
    case let .channelTalkHashing(param):
      return .requestParameters(parameters: param.toJSON(), encoding: parameterEncoding)
    case let .userRegist(param):
      return .requestJSONEncodable(param)
    case let .pincodeUserUpdate(param):
      return .requestJSONEncodable(param)
    case let .updateAppInstanceId(param):
      return .requestJSONEncodable(param)
    case let .postTerms(request):
      return .requestJSONEncodable(request)
    }
  }
  
  public var parameters: [String: Any]? {
    switch self {
    case .terms(let params):
      guard let params = params else { return [:] }
      return ["purpose": params.rawValue]
    case .inspection:
      return ["name": "inspection"]
    default:
      return [:]
    }
  }
  
  public var parameterEncoding: ParameterEncoding {
    switch self {
    case .userRegist, .userLogin, .userUpdate, .channelTalkHashing, .pincodeUserUpdate:
      return JSONEncoding.default
    default:
      return URLEncoding.queryString
    }
  }
}
