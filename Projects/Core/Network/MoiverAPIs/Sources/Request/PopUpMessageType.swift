//
//  PopUpMessageType.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/18.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public enum PopupMessageType: String, Codable {
  case Popup = "Popup"
  case Ticker = "Ticker"
  case LoanManage = "LoanManage"
  case LoanApply = "LoanApply"
  case ToolTip
  case Banner
}
