//
//  LocationPickerView.swift
//  CommunityImplementation
//
//  Created by mincheol on 10/16/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverUI
import MoiverResourcePackage
import MoiverUtils

struct LocationPickerView: View {
  let items = [
    "모두", "서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기도", "강원도", "충북", "충남", "전북", "전남", "경북", "경남", "제주"
  ] // 예시 데이터
  
  let columns = [
    GridItem(.flexible(), spacing: 8), // 첫 번째 열
    GridItem(.flexible(), spacing: 8), // 두 번째 열
    GridItem(.flexible(), spacing: 8)  // 세 번째 열
  ]
  
  @State private var selectedItem: Int? = nil // 선택된 아이템을 저장
  
  var body: some View {
    ZStack {
      VStack(alignment: .center, spacing: 0) {
        HStack {
          Spacer()
          
          Button(action: {}, label: {
            MoiverResourcePackageAsset.icnClose.swiftUIImage
          })
        }
        .padding(.top, 22)
        .padding(.trailing, 28)
        
        Text("지금, 이 동네 사람들은?!")
          .moiverFont(.title03)
          .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
          .padding(.top, 18)
        
        
        Text("궁금한 동네의 날씨 커뮤니티를 확인해보세요")
          .moiverFont(.body06)
          .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
          .padding(.top, 10)
        
        ScrollView {
          LazyVGrid(columns: columns, spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
              VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Text(items[index])
                  .frame(maxWidth: .infinity)
                  .moiverFont(selectedItem == index ? .body04 : .body05)
                  .foregroundColor(selectedItem == index ? MoiverResourcePackageAsset.black01.swiftUIColor : MoiverResourcePackageAsset.grey01.swiftUIColor)
                
                Spacer()
                
                Rectangle()
                  .frame(height: selectedItem == index ? 2 : 1)
                  .foregroundColor(selectedItem == index ? MoiverResourcePackageAsset.yellow01.swiftUIColor : MoiverResourcePackageAsset.grey01.swiftUIColor)
              }
              .frame(height: 68)
              .background(selectedItem == index ? MoiverResourcePackageAsset.yellow02.swiftUIColor : MoiverResourcePackageAsset.white01.swiftUIColor)
              .onTapGesture {
                selectedItem = (selectedItem == index) ? nil : index // 아이템 선택 및 해제
              }
              
            }
          }
          .padding([.leading, .trailing],  28)
        }
        
        HStack {
          Button(action: {}, label: {
            Text("확인")
              .moiverFont(.body04)
              .foregroundStyle(MoiverResourcePackageAsset.white01.swiftUIColor)
          })
          .frame(height: 52)
          .frame(maxWidth: .infinity) // 여전히 버튼을 전체 너비로 확장
          .background(MoiverResourcePackageAsset.yellow01.swiftUIColor)
          .cornerRadius(32)
        }
        .padding([.leading, .trailing], 28) // 패딩을 HStack에 적용
        .padding(.top, 20) // 버튼과 리스트 사이에 여백을 추가
      }
    }
  }
}

#Preview {
  LocationPickerView()
}
