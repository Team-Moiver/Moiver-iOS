//
//  HomeView.swift
//  HomeImplementation
//
//  Created by Woochan Park on 9/8/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage

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
                  .font(Font(MoiverResourcePackageFontFamily.Pretendard.bold.font(size: 48) as CTFont)
                    )
                  .lineSpacing(2)
                  .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                Spacer()
                VStack(content: {
                  HStack(content: {
                    Spacer()
                    Text("↓20°")
                      .foregroundStyle(MoiverResourcePackageAsset.blue01.swiftUIColor)
                      .font(Font(MoiverResourcePackageFontFamily.Pretendard.regular.font(size: 14) as CTFont)
                        )
                      .lineSpacing(-0.6)
                    Text("↑25°")
                      .foregroundStyle(MoiverResourcePackageAsset.red01.swiftUIColor)
                      .foregroundStyle(MoiverResourcePackageAsset.blue01.swiftUIColor)
                      .font(Font(MoiverResourcePackageFontFamily.Pretendard.regular.font(size: 14) as CTFont)
                        )
                      .lineSpacing(-0.6)
                    Text("체감 22°")
                      .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                      .font(Font(MoiverResourcePackageFontFamily.Pretendard.regular.font(size: 14) as CTFont)
                        )
                      .lineSpacing(-0.6)
                  })
                  HStack {
                    Spacer()
                    Text("어제랑 같은 온도에요")
                      .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                      .font(Font(MoiverResourcePackageFontFamily.Pretendard.medium.font(size: 20) as CTFont)
                        )
                      .lineSpacing(-0.6)
                  }
                })
              })
              HStack(content: {
                MoiverResourcePackageAsset.icnDust.swiftUIImage
                Text("나쁨")
                MoiverResourcePackageAsset.grey01.swiftUIColor
                  .frame(width: 1, height: 22)
                  .opacity(0.3)
                  .clipShape(.rect(cornerRadius: 0.5))
                MoiverResourcePackageAsset.icnWind.swiftUIImage
                Text("선선")
                MoiverResourcePackageAsset.grey01.swiftUIColor
                  .frame(width: 1, height: 22)
                  .opacity(0.3)
                  .clipShape(.rect(cornerRadius: 0.5))
                MoiverResourcePackageAsset.icnHumidity.swiftUIImage
                Text("찐득")
                MoiverResourcePackageAsset.grey01.swiftUIColor
                  .frame(width: 1, height: 22)
                  .opacity(0.3)
                  .clipShape(.rect(cornerRadius: 0.5))
                MoiverResourcePackageAsset.icnRain.swiftUIImage
                Text("60%")
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
