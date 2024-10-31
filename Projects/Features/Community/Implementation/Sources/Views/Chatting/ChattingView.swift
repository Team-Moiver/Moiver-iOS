//
//  ChattingView.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/2/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverUI
import MoiverResourcePackage

struct ChattingView: View {
  private let commnunityList: [CommunityListItem]
  
  @State private var isShowingNewView: Bool
  
  public init(commnunityList: [CommunityListItem], isShowingNewView: Bool = false) {
    self.commnunityList = commnunityList
    self.isShowingNewView = isShowingNewView
  }
  
  var body: some View {
    ZStack {
      MoiverResourcePackageAsset.yellow03.swiftUIColor
      
      ChattingItemView(
        commnunityList: commnunityList,
        isShowingNewView: $isShowingNewView
      )
      
      // 새로운 뷰가 표시될 때 딤드 처리 및 새로운 뷰
      if isShowingNewView {
        Color.black.opacity(0.5) // 딤드 배경
          .ignoresSafeArea()
        
        // 새롭게 띄울 뷰
        ChattingPopUpView(
          isShowing: $isShowingNewView,
          weatherComment: .withComment(isWrittenByUser: false)
        )
      }
      
    }
  }
}

#Preview {
  let commnunityList: [CommunityListItem] = [
    .init(
      communityUserInfo: CommunityUserInfo(id: 0, status: .normal, name: "이민철", position: "광진구", date: "AM 08:21", isUserPost: true),
      communityTag: [
        CommunityTag(name: "가죽/레더 재킷", category: .jacket),
        CommunityTag(name: "나시/민소매", category: .top),
        CommunityTag(name: "배기/조거팬츠", category: .pants)
      ]
    ),
    .init(
      communityUserInfo: CommunityUserInfo(id: 1, status: .normal, name: "박우찬", position: "성북구", date: "AM 09:21", isUserPost: false),
      communityTag: [
        CommunityTag(name: "가죽/레더 재킷", category: .jacket),
        CommunityTag(name: "나시/민소매", category: .top),
        CommunityTag(name: "배기/조거팬츠", category: .pants)
      ]
    )
  ]
  return ChattingView(commnunityList: commnunityList)
}
