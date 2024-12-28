//
//  TermView.swift
//  OnboardingInterface
//
//  Created by Woochan Park on 12/22/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage

struct TermView: View {
  
  @State var termAgree1: Bool = false
  @State var termAgree2: Bool = false
  @State var termAgree3: Bool = false
  
  private var allAgree: Bool {
    termAgree1 && termAgree2 && termAgree3
  }
  
    var body: some View {
      VStack {
        HStack {
          Button {
            
          } label: {
            MoiverResourcePackageAsset.icnBack.swiftUIImage
          }
          Spacer()
        }
        .frame(height: 50)
        
        HStack(alignment: .top) {
          titleText()
          Spacer()
          MoiverResourcePackageAsset.imgTerms.swiftUIImage
        }
        
        Button {
          let newValue = !allAgree
          termAgree1 = newValue
          termAgree2 = newValue
          termAgree3 = newValue
        } label: {
          HStack {
            if allAgree {
              MoiverResourcePackageAsset.icnCheckOn.swiftUIImage
                .padding(.leading, 12)
            } else {
              MoiverResourcePackageAsset.icnCheckOff.swiftUIImage
                .padding(.leading, 12)
            }
            Text("약관 전체동의")
              .moiverFont(.body03)
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
            
            Spacer()
          }
          .frame(height: 52)
          .cornerRadius(8) // 코너 반경
          .overlay(
              RoundedRectangle(cornerRadius: 8)
                  .stroke(MoiverResourcePackageAsset.grey01.swiftUIColor, lineWidth: 1) // 보더 추가
          )
        }
        
        HStack {
          Button {
            termAgree1.toggle()
          } label: {
            if termAgree1 {
              MoiverResourcePackageAsset.icnCheckOn.swiftUIImage
                .padding(.leading, 12)
            } else {
              MoiverResourcePackageAsset.icnCheckOff.swiftUIImage
                .padding(.leading, 12)
            }
            Text("(필수) 모이버 서비스 약관 동의")
              .moiverFont(.body03)
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
          }
          Spacer()
        }
        .padding(.top, 22)
        
        HStack {
          Button {
            termAgree2.toggle()
          } label: {
            if termAgree2 {
              MoiverResourcePackageAsset.icnCheckOn.swiftUIImage
                .padding(.leading, 12)
            } else {
              MoiverResourcePackageAsset.icnCheckOff.swiftUIImage
                .padding(.leading, 12)
            }
            
            Text("(필수) 개인정보 처리 방침 동의")
              .moiverFont(.body03)
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
          }
          Spacer()
        }
        .padding(.top, 22)
        
        HStack {
          Button {
            termAgree3.toggle()
          } label: {
            if termAgree3 {
              MoiverResourcePackageAsset.icnCheckOn.swiftUIImage
                .padding(.leading, 12)
            } else {
              MoiverResourcePackageAsset.icnCheckOff.swiftUIImage
                .padding(.leading, 12)
            }
            Text("(선택) 위치 기반 기능 동의")
              .moiverFont(.body03)
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
          }
          Spacer()
        }
        .padding(.top, 22)
        
        Spacer()
        
        Button {
          
        } label: {
          ZStack {
            MoiverResourcePackageAsset.yellow01.swiftUIColor
              .frame(height: 52)
              .clipShape(.rect(cornerRadius: 26))
            Text("동의하고 시작하기")
              .moiverFont(.body03)
              .foregroundStyle(MoiverResourcePackageAsset.yellow02.swiftUIColor)
          }
        }
        .padding(.horizontal, 4)
      }
      .padding(.horizontal, 25)
    }
  
  func titleText() -> some View {
    VStack(alignment: .leading) {
      Text("모이버에 오신걸 환영해요!")
        .moiverFont(.body01)
      HStack(spacing: 0) {
        Text("약관내용에 동의")
          .moiverFont(.body01)
          .foregroundStyle(MoiverResourcePackageAsset.yellow01.swiftUIColor)
        Text("해주세요.")
          .moiverFont(.body01)
      }
    }
    .padding(.top, 9)
  }
}

#Preview {
    TermView()
}
