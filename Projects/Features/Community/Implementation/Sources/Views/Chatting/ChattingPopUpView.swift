//
//  ChattingPopUpView.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/31/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverUI
import MoiverResourcePackage

struct ChattingPopUpView: View {
  @Binding var isShowing: Bool
  let weatherComment: WeatherComment
  
  var body: some View {
    VStack {
      ForEach(Array(weatherComment.items.enumerated()), id: \.element) { index, item in
        HStack {
          item.image
          Text(item.name)
            .padding(.leading, 4)
            .moiverFont(.body05)
            .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
        }
        .frame(height: 50)
        .onTapGesture {
          isShowing = false
        }
        
        if index < weatherComment.items.count - 1 { // 마지막 아이템이 아닌 경우에만 라인 추가
          Divider()
            .frame(height: 1) // 높이 1로 설정
            .background(MoiverResourcePackageAsset.grey02.swiftUIColor) // 원하는 색상으로 설정
        }
      }
    }
    .frame(width: UIScreen.main.bounds.width - 56)
    .background(MoiverResourcePackageAsset.white01.swiftUIColor)
    .cornerRadius(12)
    .shadow(radius: 10)
  }
}

#Preview {
  
  @State var isShowingNewView: Bool = false
  
    return ChattingPopUpView(
      isShowing: $isShowingNewView,
      weatherComment: .withComment(isWrittenByUser: false)
    )
}
