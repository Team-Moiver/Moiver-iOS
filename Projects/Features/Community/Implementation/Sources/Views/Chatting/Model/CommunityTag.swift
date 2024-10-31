//
//  CommunityTag.swift
//  CommunityInterface
//
//  Created by mincheol on 10/17/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import Foundation

struct CommunityTag: Hashable {
  var name: String
  var category: CommunityTagCategoty
  
  init(name: String, category: CommunityTagCategoty) {
    self.name = name
    self.category = category
  }
}
