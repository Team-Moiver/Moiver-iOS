//
//  HomeView.swift
//  HomeImplementation
//
//  Created by Woochan Park on 9/8/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage
import MoiverUI

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
  
  @State private var isVisible1 = false
  @State private var isVisible2 = false
  @State private var isVisible3 = false
  @State private var isVisible4 = false
  @State private var isVisible5 = false
  @State private var isVisible6 = false
  
  @State private var offsetY: CGFloat = -70 // 시작 위치 (화면 위쪽)

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
          .opacity(isVisible1 ? 1 : 0)
          .animation(.easeIn(duration: 0.4), value: isVisible1)
          
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
          .opacity(isVisible2 ? 1 : 0)
          .animation(.easeIn(duration: 0.4), value: isVisible2)
          
          ZStack(alignment: .top) {
            HStack {
              MoiverResourcePackageAsset.back1Sun1.swiftUIImage
                .frame(width: 225, height: 306)
              Spacer()
            }
            
            VStack {
              Spacer()
              HStack {
                Spacer()
                MoiverResourcePackageAsset.clothes17.swiftUIImage
                  .frame(
                    width: 375,
                    height: 240
                  )
              }
              Spacer()
                .frame(height: 20)
            }
              .opacity(isVisible6 ? 1 : 0)
              .offset(y: offsetY) // Y축 위치 변경
              .animation(
                .interpolatingSpring(stiffness: 70, damping: 8),
                value: isVisible6
              ) // 스프링 애니메이션 적용
            
            
            VStack {
              HStack {
                Text("7월 15일 월요일")
                  .moiverFont(.body05)
                  .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                Spacer()
              }
              .padding(.horizontal, 22)
              .padding(.top, 16)
              .opacity(isVisible3 ? 1 : 0)
              .animation(.easeIn(duration: 0.4), value: isVisible3)
              
              HStack {
                Text("산들산들한 바람이 불어오는 하루야")
                  .moiverFont(.body03)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 10)
                  .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                  .background(MoiverResourcePackageAsset.white02.swiftUIColor)
                  .clipShape(.rect(cornerRadius: 8))
                Spacer()
              }
              .padding(.horizontal, 22)
              .padding(.top, 6)
              .opacity(isVisible3 ? 1 : 0)
              .animation(.easeIn(duration: 0.4), value: isVisible3)
              
              HStack {
                Text("너무 습해! 여기 사우나 아니야?")
                  .moiverFont(.body03)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 10)
                  .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                  .background(MoiverResourcePackageAsset.white02.swiftUIColor)
                  .clipShape(.rect(cornerRadius: 8))
                Spacer()
              }
              .padding(.horizontal, 22)
              .padding(.top, 6)
              .opacity(isVisible4 ? 1 : 0)
              .animation(.easeIn(duration: 0.4), value: isVisible4)
              
              HStack {
                Text("무더운 날, 수분 보충을 잊지마!")
                  .padding(.horizontal, 12)
                  .padding(.vertical, 10)
                  .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
                  .moiverFont(.body03)
                  .background(MoiverResourcePackageAsset.white02.swiftUIColor)
                  .clipShape(.rect(cornerRadius: 8))
                Spacer()
              }
              .padding(.horizontal, 22)
              .padding(.top, 6)
              .opacity(isVisible5 ? 1 : 0)
              .animation(.easeIn(duration: 0.4), value: isVisible5)
            }
            .padding(.top, 0)
          }
          .padding(.top, 8)
          
          Spacer()
        })
      })
      .onAppear(perform: {
        self.fadeIn()
      })
    }
  
  private func fadeIn() {
    withAnimation {
        isVisible1 = true
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        withAnimation {
            isVisible2 = true
        }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        withAnimation {
            isVisible3 = true
        }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
        withAnimation {
            isVisible4 = true
        }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
        withAnimation {
            isVisible5 = true
        }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        withAnimation {
            isVisible6 = true
            offsetY = 0
        }
    }
  }
}


#Preview {
    HomeView()
}
