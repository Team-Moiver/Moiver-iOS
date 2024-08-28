//
//  AutoLoanAPI.swift
//  Finda
//
//  Created by 박영진 on 2022/03/14.
//  Copyright © 2022 Finda. All rights reserved.
//

import Moya

public enum AutoLoanAPI {
    case banks
    case application(AutoLoanApplicationRequest)
    case progress(Int)
    case latest
    case applicationResult(Int)
    case loanApply(Int, Int)
    case releaseNotification(AutoLoanReleaseNotificationRequest)
    case contract(Int, Int)
}

extension AutoLoanAPI: BaseAPI {
    public var path: String {
        switch self {
        case .banks:
            return "/autoloan/v1/banks"
        case .application:
            return "/autoloan/v1/application"
        case .progress(let id):
            return "/autoloan/v1/application/\(id)/progress"
        case .latest:
            return "/autoloan/v1/application/latest"
        case .applicationResult(let id):
            return "/autoloan/v1/application/\(id)"
        case let .loanApply(applicationId, loanApplyId):
            return "/autoloan/v1/application/\(applicationId)/loanapply/\(loanApplyId)"
        case .releaseNotification:
            return "/autoloan/v1/notification/release"
        case let .contract(applicationId, loanApplyId):
            return "/autoloan/v1/application/\(applicationId)/loanapply/\(loanApplyId)/contract"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .banks:
            return .get
        case .application:
            return .post
        case .progress:
            return .get
        case .latest:
            return .get
        case .applicationResult:
            return .get
        case .loanApply:
            return .get
        case .releaseNotification:
            return .post
        case .contract:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .banks:
            return .requestPlain
        case .application(let params):
            return .requestJSONEncodable(params)
        case .progress:
            return .requestPlain
        case .latest:
            return .requestPlain
        case .applicationResult:
            return .requestPlain
        case .loanApply:
            return .requestPlain
        case .releaseNotification(let params):
            return .requestJSONEncodable(params)
        case .contract:
            return .requestPlain
        }
    }
}
