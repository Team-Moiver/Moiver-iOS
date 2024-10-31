//
//  TopBar.swift
//  CommunityImplementation
//
//  Created by mincheol on 9/15/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import SwiftUI
import MoiverResourcePackage
import MoiverUI

extension CommunityView {
  struct TopBar: View {
    var body: some View {
      HStack(alignment: .top, spacing: 0) {
        MoiverResourcePackageAsset.icnLocationDay.swiftUIImage
          .padding(.trailing, 3)
        
        Text("서울의 옷차림")
          .moiverFont(.title03)
          .padding(.trailing, 3)
          .foregroundStyle(MoiverResourcePackageAsset.black01.swiftUIColor)
        
        MoiverResourcePackageAsset.icnDropDown1.swiftUIImage
        
        Spacer()
        
        MoiverResourcePackageAsset.icnMenuDay.swiftUIImage
      }
      .padding([.leading, .trailing], 16)
        
    }
  }
}

#Preview {
  CommunityView.TopBar()
}
