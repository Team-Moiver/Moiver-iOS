//
//  MoyaAccessTokenPlugin.swift
//  Finda
//
//  Created by 엄기철 on 2021/04/23.
//  Copyright © 2021 Finda. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
import Moya
import FindaUtils

public final class MoyaAccessTokenPlugin: PluginType {
    
    var signatureKey: String?
    
    public init() {}
    
    public init(signatureKey: String? = nil) {
        self.signatureKey = signatureKey
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        let token = UserDefaultManager.shared.userToken ?? ""
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        let secretKey = parseKeys().secretKey
        let version = appVersion()
        
        if let deviceId = deviceId {
            request.addValue(deviceId, forHTTPHeaderField: "X-Client-Device-Id")
            
            if signatureKey == nil {
                signatureKey = "\(deviceId)\(secretKey)".md5()
            }
            request.addValue(signatureKey!, forHTTPHeaderField: "X-Signature-V1")
        }
        
        request.addValue(OsType.iOS.rawValue, forHTTPHeaderField: "X-Client-App-Os-Type")
        request.addValue(version, forHTTPHeaderField: "X-Client-App-Version")
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        request.addValue("no-store", forHTTPHeaderField: "Cache-Control")
        
        return request
    }
}
