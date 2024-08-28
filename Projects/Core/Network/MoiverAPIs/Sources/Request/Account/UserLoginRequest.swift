//
//  UserLoginRequest.swift
//  Finda
//
//  Created by 박영진 on 2020/10/23.
//  Copyright © 2020 Finda. All rights reserved.
//

import Foundation

public struct UserLoginRequest: Encodable {
    public var userId: Int
    public var encryptedPincode: String
    public var userDevice: Device
    public var mixpanelId: String
    
    public init(userId: Int, encryptedPincode: String, userDevice: Device, mixpanelId: String) {
      self.userId = userId
      self.encryptedPincode = encryptedPincode
      self.userDevice = userDevice
      self.mixpanelId = mixpanelId
    }
}

extension UserLoginRequest {
    public struct Device: Encodable {
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
}
