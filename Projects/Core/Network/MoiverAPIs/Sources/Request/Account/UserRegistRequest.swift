//
//  UserRegisterRequest.swift
//  Finda
//
//  Created by donghyun on 2022/11/21.
//  Copyright © 2022 Finda. All rights reserved.
//

import Foundation
import FindaUtils

public struct UserRegisterRequest: Codable {
    public var encryptedPincode: String?
    public var idToken: String?
    public var appInstanceId: String?
    public var userDevice: UserRegisterRequest.Device?
    public var userTermsList: [UserRegisterRequest.TermsList]?
    public var channelType: UserChannelType?
    public var referralCode: String?
    
    public init(encryptedPincode: String? = nil, idToken: String? = nil, appInstanceId: String? = nil, userDevice: UserRegisterRequest.Device? = nil, userTermsList: [UserRegisterRequest.TermsList]? = nil, channelType: UserChannelType? = nil, referralCode: String? = nil) {
        self.encryptedPincode = encryptedPincode
        self.idToken = idToken
        self.appInstanceId = appInstanceId
        self.userDevice = userDevice
        self.userTermsList = userTermsList
        self.channelType = channelType
        self.referralCode = referralCode
    }
}

extension UserRegisterRequest {
    public struct Device: Codable {
        public var deviceId: String?
        public var manufacture: String?
        public var model: String?
        public var notiToken: String?
        public var appsflyerId: String?
        public var adId: String?
        public var osType: String?
        public var osVersion: String?
        public var appVersion: String?
        public var notiEnabled: Bool?
        
        public init(deviceId: String? = nil, manufacture: String? = nil, model: String? = nil, notiToken: String? = nil, appsflyerId: String? = nil, adId: String? = nil, osType: String? = nil, osVersion: String? = nil, appVersion: String? = nil, notiEnabled: Bool? = nil) {
            self.deviceId = deviceId
            self.manufacture = manufacture
            self.model = model
            self.notiToken = notiToken
            self.appsflyerId = appsflyerId
            self.adId = adId
            self.osType = osType
            self.osVersion = osVersion
            self.appVersion = appVersion
            self.notiEnabled = notiEnabled
        }
    }
    
    public struct TermsList: Codable {
        public var id: Int?
        public var agree: Bool?
        
        public init(id: Int? = nil, agree: Bool? = nil) {
            self.id = id
            self.agree = agree
        }
    }
}

public enum UserChannelType: String, Codable {
    case BAEMIN_CEO, BAEMIN_RIDER
    
    public var fromBaemin: Bool {
        switch self {
        case .BAEMIN_CEO, .BAEMIN_RIDER:
            return true
        }
    }
}

extension UserChannelType {
  public init?(fromAppPage: String) {
    switch AppPageType(rawValue: fromAppPage) {
    case .BAEMIN_CEO:
      self = .BAEMIN_CEO
    case .BAEMIN_RIDER:
      self = .BAEMIN_RIDER
    default:
      return nil
    }
  }
}

