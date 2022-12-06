//
//  AppRouter.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI
import EventKit

enum checkyRouter: NavigationRouter {
  case main
  
  var transition: NavigationTranisitionStyle {
    switch self {
    case .main:
      return .push
    }
  }
  
  @ViewBuilder
  func view() -> some View {
    switch self {
    case .main:
      ContentView()
    }
  }
}
