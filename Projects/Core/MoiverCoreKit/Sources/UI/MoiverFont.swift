//
//  MoiverFont.swift
//  MoiverCoreKit
//
//  Created by Woochan Park on 9/9/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import MoiverResourcePackage
import SwiftUI

struct MoiverFontModifier: ViewModifier {
  let textStyle: MoiverTextStyle

  func body(content: Content) -> some View {
    content
      .font(Font(textStyle.font as CTFont))
      .lineSpacing(textStyle.lineSpacing)
  }
}

public extension View {
  func moiverFont(_ textStyle: MoiverTextStyle) -> some View {
    self.modifier(MoiverFontModifier(textStyle: textStyle))
  }
}
