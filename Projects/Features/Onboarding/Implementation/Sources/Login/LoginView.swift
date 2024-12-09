//
//  LoginView.swift
//  OnboardingInterface
//
//  Created by Woochan Park on 12/9/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverUI
import MoiverResourcePackage

struct LoginView: View {
  var body: some View {
    ZStack {
      backgroundView()
      buttonView()
    }
  }
  
  private func backgroundView() -> some View {
    VStack {
      MoiverResourcePackageAsset.icnLogo.swiftUIImage
        .padding(.top, 116)
      Spacer()
        .frame(height: 72)
      MoiverResourcePackageAsset.backAndLogin.swiftUIImage
        .resizable()
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.container, edges: .bottom)
    }
  }
  
  private func buttonView() -> some View {
    VStack(spacing: 0) {
      Spacer()
      VStack(spacing: 10) {
        kakaoButtonView()
        appleButtonView()
      }
      .padding(.horizontal, 33)
      skipButtonView()
    }
  }
  
  private func kakaoButtonView() -> some View {
    Button(action: {
      
    }, label: {
      HStack {
        MoiverResourcePackageAsset.icnKakao.swiftUIImage
        Spacer()
        Text("카카오 로그인")
          .moiverFont(.body05)
          .foregroundStyle(.black)
        Spacer()
      }
      .padding(.horizontal, 26)
    })
    .frame(height: 48)
    .background(Color(red: 254 / 255, green: 229 / 255, blue: 0 / 255))
    .clipShape(.rect(cornerRadius: 24))
  }
  
  private func appleButtonView() -> some View {
    Button(action: {
      
    }, label: {
      HStack {
        MoiverResourcePackageAsset.icnApple.swiftUIImage
        Spacer()
        Text("Apple로 로그인")
          .moiverFont(.body05)
          .foregroundStyle(.black)
        Spacer()
      }
      .padding(.horizontal, 26)
    })
    .frame(height: 48)
    .background(Color.white)
    .clipShape(.rect(cornerRadius: 24))
  }
  
  private func skipButtonView() -> some View {
    Button(action: {
      
    }, label: {
      HStack {
        Spacer()
        Text("로그인 없이 사용하기")
          .underline()
          .foregroundStyle(MoiverResourcePackageAsset.white01.swiftUIColor)
        Spacer()
      }
      .padding(.horizontal, 26)
    })
    .frame(height: 22)
    .padding(.top, 16)
    .padding(.bottom, 12)
  }
}

#Preview {
  LoginView()
}
