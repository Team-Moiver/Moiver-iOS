//
//  CommunityTagCategoty.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/17/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import Foundation
import SwiftUI
import MoiverResourcePackage

enum CommunityTagCategoty {
  case jacket
  case top
  case pants
  
  var image: SwiftUI.Image {
    switch self {
    case .jacket:
      return MoiverResourcePackageAsset.icnJacket.swiftUIImage
    case .pants:
      return MoiverResourcePackageAsset.icnTop.swiftUIImage
    case .top:
      return MoiverResourcePackageAsset.icnPants.swiftUIImage
    }
  }
}
