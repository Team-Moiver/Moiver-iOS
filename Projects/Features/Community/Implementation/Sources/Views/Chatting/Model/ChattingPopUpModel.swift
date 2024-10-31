//
//  ChattingPopUpModel.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/31/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage

enum WeatherComment {
  case withComment(isWrittenByUser: Bool)  // 코멘트와 작성 여부 포함
  case noComment(isWrittenByUser: Bool) // 작성 여부만 포함, 코멘트 없음
  
  var items: [ChattingPopUpType] {
    switch self {
    case .withComment(let isWrittenByUser):
      if isWrittenByUser {
        return [.edit, .delete]
      } else {
        return [.heart, .report]
      }
    case .noComment(let isWrittenByUser):
      if isWrittenByUser {
        return [.edit, .delete]
      } else {
        return [.heart]
      }
    }
  }
}

enum ChattingPopUpType {
  case edit
  case report
  case heart
  case delete
  
  var name: String {
    switch self {
    case .edit:
      return "수정하기"
    case .report:
      return "신고하기"
    case .heart:
      return "공감하기"
    case .delete:
      return "삭제하기"
    }
  }
  var image: Image {
    switch self {
    case .edit:
      return MoiverResourcePackageAsset.icnEdit.swiftUIImage
    case .report:
      return MoiverResourcePackageAsset.icnReport.swiftUIImage
    case .heart:
      return MoiverResourcePackageAsset.icnHeart.swiftUIImage
    case .delete:
      return MoiverResourcePackageAsset.icnDelete.swiftUIImage
    }
  }
}
