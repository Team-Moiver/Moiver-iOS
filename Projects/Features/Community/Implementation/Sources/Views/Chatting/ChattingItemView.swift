//
//  ChattingItemView.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/31/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverUI
import MoiverResourcePackage

struct ChattingItemView: View {
  private let commnunityList: [CommunityListItem]
  @Binding private var isShowingNewView: Bool
  
  public init(commnunityList: [CommunityListItem], isShowingNewView: Binding<Bool>) {
    self.commnunityList = commnunityList
    self._isShowingNewView = isShowingNewView
  }
  
    var body: some View {
      VStack(spacing: 0) {
        ForEach(commnunityList, id: \.self) { item in
          HStack(alignment: .center, spacing: 0) {
            item.communityUserInfo.status.image
            Text(item.communityUserInfo.name)
              .moiverFont(.body09)
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
              .padding(.leading, 4)
              .padding([.top, .bottom], 7)
            
            Text("\(item.communityUserInfo.position) | \(item.communityUserInfo.date)")
              .moiverFont(.body10)
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
              .padding(.leading, 8)
              .padding([.top, .bottom], 6)
          }
          .frame(maxWidth: .infinity, alignment: item.communityUserInfo.isUserPost ? .trailing : .leading)
          .padding(item.communityUserInfo.isUserPost ? .trailing : .leading, 16)
          
          ZStack(alignment: .top) {
            item.communityUserInfo.isUserPost ? MoiverResourcePackageAsset.yellow02.swiftUIColor : MoiverResourcePackageAsset.white01.swiftUIColor
            
            VStack(alignment: .leading, spacing: 0) {
              Text("공백 포함 45자 이내만 작성 가능해요 공백 포함 45자 이내만 작성 가능해요 공백 포함 45자 이내만 작성 공")
                .moiverFont(.body08)
                .foregroundStyle(MoiverResourcePackageAsset.black02.swiftUIColor)
                .padding(.top, 10)
                .padding([.leading, .trailing], 14)
              
              HStack(alignment: .center, spacing: 0) {
                ForEach(item.communityTag, id: \.self) { communityTag in
                  HStack(alignment: .center, spacing: 0) {
                    communityTag.category.image
                    Text(communityTag.name)
                      .moiverFont(.body11)
                      .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                      .padding([.leading, .trailing], 4)
                      .padding([.top, .bottom], 1)
                  }
                  .padding([.leading, .trailing, .top, .bottom], 4)
                  .onLongPressGesture(minimumDuration: 0.3) {
                    // onLongPressGesture에서 상태 업데이트
                    isShowingNewView = true
                  }
                }
              }
              .padding(.bottom, 10)
              .padding([.leading, .trailing], 14)
            }
          }
          .clipShape(
            .rect(
              topLeadingRadius: item.communityUserInfo.isUserPost ? 12 : 4,
              bottomLeadingRadius: 12,
              bottomTrailingRadius: 12,
              topTrailingRadius: item.communityUserInfo.isUserPost ? 4 : 12
            )
          )
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: UIScreen.main.bounds.width - 26 - 41,alignment: item.communityUserInfo.isUserPost ? .leading : .trailing)
          .padding(item.communityUserInfo.isUserPost ? .leading : .trailing, 26)
          .padding(.top, 4)
        }
      }
      .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
}

#Preview {
  @State var isShowingNewView: Bool = false
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
    return ChattingItemView(
      commnunityList: commnunityList,
      isShowingNewView: $isShowingNewView
    )
}
