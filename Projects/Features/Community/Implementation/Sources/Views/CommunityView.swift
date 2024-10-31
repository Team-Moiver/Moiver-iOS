//
//  CommunityView.swift
//  CommunityImplementation
//
//  Created by mincheol on 9/15/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage
import MoiverUI

struct CommunityView: View {
  let commnunityList: [CommunityListItem]
  
  var body: some View {
    ZStack {
      MoiverResourcePackageAsset.yellow03.swiftUIColor
      
      VStack(alignment: .leading, spacing: 0) {
        TopBar()
          .frame(height: 60)
        
        HStack(alignment: .center, spacing: 0) {
          Text("2024.08.19")
            .moiverFont(.body11)
            .foregroundStyle(MoiverResourcePackageAsset.grey01.swiftUIColor)
            .padding(.leading, 26)
          
          Spacer()
          
          Text("내 기록")
            .moiverFont(.body08)
            .foregroundStyle(MoiverResourcePackageAsset.black02.swiftUIColor)
            .padding([.top, .bottom], 7)
            .padding(.trailing, 10)
          
          Toggle(isOn: .constant(false), label: {})
            .frame(width: 32, height: 32)
            .scaleEffect(0.5)
            .padding(.trailing, 16)
          
        }
        
        ChattingView(commnunityList: self.commnunityList)
      }
      .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
    }
    .ignoresSafeArea()
    
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
  
  return CommunityView(commnunityList: commnunityList)
}

