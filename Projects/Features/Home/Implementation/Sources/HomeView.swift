//
//  HomeView.swift
//  HomeImplementation
//
//  Created by Woochan Park on 9/8/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage
import MoiverCoreKit

enum SunPhase {
  case sunrise
  case sunset
  
  var backGroundColor: Color {
    switch self {
    case .sunrise:
      MoiverResourcePackageAsset.yellow03.swiftUIColor
    case .sunset:
      MoiverResourcePackageAsset.black02.swiftUIColor
    }
  }
}

struct HomeView: View {
  
  @State var sunPhase: SunPhase = .sunrise
  
    var body: some View {

      ZStack(content: {
        sunPhase.backGroundColor
          .edgesIgnoringSafeArea(.all)
        VStack(content: {
          HStack(content: {
            MoiverResourcePackageAsset.icnLocation.swiftUIImage
            Text("서울 성북구")
            Button(action: {
              print("DropDown")
            }, label: {
              MoiverResourcePackageAsset.icnDropDown1.swiftUIImage
            })
            Spacer()
            Button(action: {
              print("Menu")
            }, label: {
              MoiverResourcePackageAsset.icnMenu.swiftUIImage
            })
          })
          .padding(.horizontal, 16)
          .padding(.vertical, 18)
          
          HStack {
            Spacer()
              .frame(width: 16)
            VStack(spacing: 18, content: {
              HStack(content: {
                MoiverResourcePackageAsset.icnSunL.swiftUIImage
                Spacer()
                  .frame(width: 12)
                Text("31°")
                  .moiverFont(.title01)
                  .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                Spacer()
                VStack(content: {
                  HStack(content: {
                    Spacer()
                    Text("↓20°")
                      .foregroundStyle(MoiverResourcePackageAsset.blue01.swiftUIColor)
                      .moiverFont(.body07)
                    Text("↑25°")
                      .foregroundStyle(MoiverResourcePackageAsset.red01.swiftUIColor)
                      .moiverFont(.body07)
                    Text("체감 22°")
                      .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                      .moiverFont(.body07)
                  })
                  HStack {
                    Spacer()
                    Text("어제랑 같은 온도에요")
                      .moiverFont(.body01)
                      .lineSpacing(-0.6)
                  }
                })
              })
              HStack(content: {
                MoiverResourcePackageAsset.icnDust.swiftUIImage
                Text("나쁨")
                  .moiverFont(.body04)
                MoiverResourcePackageAsset.grey01.swiftUIColor
                  .frame(width: 1, height: 22)
                  .opacity(0.3)
                  .clipShape(.rect(cornerRadius: 0.5))
                MoiverResourcePackageAsset.icnWind.swiftUIImage
                Text("선선")
                  .moiverFont(.body04)
                MoiverResourcePackageAsset.grey01.swiftUIColor
                  .frame(width: 1, height: 22)
                  .opacity(0.3)
                  .clipShape(.rect(cornerRadius: 0.5))
                MoiverResourcePackageAsset.icnHumidity.swiftUIImage
                Text("찐득")
                  .moiverFont(.body04)
                MoiverResourcePackageAsset.grey01.swiftUIColor
                  .frame(width: 1, height: 22)
                  .opacity(0.3)
                  .clipShape(.rect(cornerRadius: 0.5))
                MoiverResourcePackageAsset.icnRain.swiftUIImage
                Text("60%")
                  .moiverFont(.body04)
              })
              .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
            })
            .padding(.vertical, 20)
            .padding(.leading, 18)
            .padding(.trailing, 17)
            .background(MoiverResourcePackageAsset.white01.swiftUIColor)
            .clipShape(.rect(cornerRadius: 8))
            Spacer()
              .frame(width: 16)
          }
          Spacer()
        })
      })
    }
}

#Preview {
    HomeView()
}
