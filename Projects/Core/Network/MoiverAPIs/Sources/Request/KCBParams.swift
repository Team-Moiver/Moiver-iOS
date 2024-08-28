//
//  KCBParams.swift
//  Finda
//
//  Created by 박영진 on 2021/08/03.
//  Copyright © 2021 Finda. All rights reserved.
//

public enum KCBParams: String {
    case mainHome
    case loanmanage
    case credit
    case loanapply
    
    public var map: [String: String] {
        return ["source": self.rawValue]
    }
}
