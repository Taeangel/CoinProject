//
//  DetailCoinViewModel.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

class DetailCoinViewModel: ObservableObject {
  
  @Published var coin: CoinModel
  let coinDetailService: CoinDetailDataService
  
  init(coin: CoinModel) {
    self.coin = coin
    self.coinDetailService = CoinDetailDataService(coin: coin)
  }
}
