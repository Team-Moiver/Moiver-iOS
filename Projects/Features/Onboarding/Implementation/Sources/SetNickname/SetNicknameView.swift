//
//  SetNicknameView.swift
//  OnboardingInterface
//
//  Created by Woochan Park on 12/22/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage

struct SetNicknameView: View {
  @State private var nickname: String = ""
  @State private var nicknameCreationGuide: String = "12글자 이내로 작성해 주세요 😓"
  
  enum Constants {
    static let title = """
    반가워요!
    사용할 닉네임을 입력해주세요
    """
  }
  
  var body: some View {
    VStack {
      HStack {
        Button {
          
        } label: {
          MoiverResourcePackageAsset.icnClose.swiftUIImage
            .padding(18)
        }
        Spacer()
      }
      Spacer()
        .frame(height: 63)
      Text(Constants.title)
        .moiverFont(.title03)
        .multilineTextAlignment(.center)
      Spacer()
        .frame(height: 97)
      VStack {
        TextField("시스템 제공 닉네임", text: $nickname)
          .multilineTextAlignment(.center)
        MoiverResourcePackageAsset.yellow01.swiftUIColor
          .frame(height: 2)
        Text(nicknameCreationGuide)
          .moiverFont(.body07)
          .padding(.top, 14)
      }
      .padding(.horizontal, 66)
      
      Spacer()
      
      Button {
        
      } label: {
        ZStack {
          MoiverResourcePackageAsset.yellow01.swiftUIColor
            .frame(height: 52)
            .clipShape(.rect(cornerRadius: 26))
          Text("다음")
            .moiverFont(.body03)
            .foregroundStyle(MoiverResourcePackageAsset.yellow02.swiftUIColor)
        }
      }
      .padding(.horizontal, 28)
      
      Spacer()
        .frame(height: 23)
    }
  }
}

#Preview {
  SetNicknameView()
}
