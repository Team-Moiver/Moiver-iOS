//
//  IdCertAPI.swift
//  Finda
//
//  Created by 박영진 on 2022/03/03.
//  Copyright © 2022 Finda. All rights reserved.
//

import Moya

public enum IdCertAPI {
    case ids(IdsTxRequest)
    case idsResult(IdsTxResultRequest)
    case realname(KcbRealNameRequest)
    // MO
    case messageInfo
    case checkCertification(icCode: String)
    // OverAge
    case overAge(param: OverAgeRequest)
    case overAgeRegist(request: OverAgeRegistRequest)
}

extension IdCertAPI: BaseAPI {
    public var path: String {
        switch self {
        case .ids, .idsResult:
            return "/idcert/v1/ids"
        case .realname:
            return "/idcert/v1/realname"
        case .messageInfo:
            return "/idcert/v1/mo/certification"
        case .checkCertification(let icCode):
            return "/idcert/v1/mo/certification/\(icCode)"
        case .overAge:
            return "/idcert/v1/age/overage-rrn"
        case .overAgeRegist:
            return "/idcert/v1/age/overage-regist"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .ids, .realname, .messageInfo, .overAge, .overAgeRegist:
            return .post
        case .idsResult:
            return .put
        case .checkCertification:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .ids(let params):
            return .requestJSONEncodable(params)
        case .idsResult(let params):
            return .requestJSONEncodable(params)
        case .realname(let params):
            return .requestJSONEncodable(params)
        case .messageInfo, .checkCertification:
            return .requestPlain
        case let .overAge(param):
            return .requestParameters(parameters: param.toJSON(), encoding: parameterEncoding)
        case let .overAgeRegist(request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .overAge:
            return JSONEncoding.default
        default:
            return URLEncoding.queryString
        }
    }
}
