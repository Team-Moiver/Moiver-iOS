//
//  TextStyle.swift
//  MoiverResourcePackage
//
//  Created by Woochan Park on 9/8/24.
//  Copyright © 2024 Moiver. All rights reserved.
//

import Foundation
import UIKit.UIFont

public enum MoiverTextStyle {
  case title01
  case title02
  case body01
  case body02
  case body03
  case body04
  case body05
  case body06
  case body07
  case body08
  case body09
  
  public var font: UIFont {
    self.weight.font(size: self.fontSize)
  }
  
  public var weight: MoiverResourcePackageFontConvertible {
    return switch self {
    case .title01:
      MoiverResourcePackageFontFamily.Pretendard.bold
      
    case .title02,
        .body05,
        .body08
      :
      MoiverResourcePackageFontFamily.Pretendard.semiBold
      
    case .body01,
        .body02,
        .body03,
        .body06:
      MoiverResourcePackageFontFamily.Pretendard.medium
      
    case .body04,
        .body07,
        .body09:
      MoiverResourcePackageFontFamily.Pretendard.regular
    }
  }
  
  public var fontSize: CGFloat {
    return switch self {
    case .title01:
      48
    case .title02,
        .body01:
      20
    case .body02:
      18
    case .body03,
        .body04:
      16
    case .body05,
        .body06,
        .body07:
      14
    case .body08,
        .body09:
      12
    }
  }
  
  public var lineSpacing: CGFloat {
    -0.6
  }
}
