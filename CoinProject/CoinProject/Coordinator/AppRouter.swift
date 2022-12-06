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
  case detail(CoinModel)
  
  var transition: NavigationTranisitionStyle {
    switch self {
    case .main:
      return .push
    case .detail:
      return .push
    }
  }
  
  @ViewBuilder
  func view() -> some View {
    switch self {
    case .main:
      MainView(vm: MainCoinViewModel(coinsDataService: CoinsDataService()))
    case .detail(let coin):
      DetailCoinView(coin: coin)
    }
  }
}
