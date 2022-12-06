//
//  MainCoinViewModel.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

class MainCoinViewModel: ObservableObject {
  @Published var searchText: String = ""
  
  let coinsDataService: CoinsDataFetchable
  
  init(coinsDataService: CoinsDataFetchable) {
    self.coinsDataService = coinsDataService
  }
}
