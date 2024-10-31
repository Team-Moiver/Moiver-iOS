//
//  CommunityUserInfo.swift
//  CommunityInterface
//
//  Created by mincheol on 10/17/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import Foundation
import SwiftUI
import MoiverResourcePackage

struct CommunityUserInfo: Hashable {
  var id: Int
  var status: CommunityUserInfo.Status
  var name: String
  var position: String
  var date: String
  var isUserPost: Bool
  
  enum Status {
    case normal
    
    var image: SwiftUI.Image {
      switch self {
      case .normal:
        return MoiverResourcePackageAsset.imgGood.swiftUIImage
      }
    }
  }
}
