//
//  CommunityListItem.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/30/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import Foundation
import SwiftUI
import MoiverResourcePackage

struct CommunityListItem: Hashable {
  var communityUserInfo: CommunityUserInfo
  var communityTag: [CommunityTag]
  
  init(communityUserInfo: CommunityUserInfo, communityTag: [CommunityTag]) {
    self.communityUserInfo = communityUserInfo
    self.communityTag = communityTag
  }
  
}
