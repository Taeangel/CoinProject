//
//  DetailCoinViewModel.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

class DetailCoinViewModel: ObservableObject {
  
  @Published var coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
  }
}
