//
//  PostTerm.swift
//  FindaAPIs
//
//  Created by woochan on 5/31/24.
//  Copyright © 2024 Finda. All rights reserved.
//

import Foundation

public struct PostTerm: Encodable {
  public var termsId: Int
  public var agree: Bool
  
  public init(termsId: Int, agree: Bool) {
    self.termsId = termsId
    self.agree = agree
  }
}
