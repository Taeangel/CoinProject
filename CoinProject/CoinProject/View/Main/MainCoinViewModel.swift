//
//  MainCoinViewModel.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

class MainCoinViewModel: ObservableObject {
  @Published var searchText: String = ""
  @Published var coins: [CoinModel] = []
  
  private let coinsDataService: CoinsDataFetchable
  private var cancellalbes = Set<AnyCancellable>()
  let coinDataService = CoinsDataService()
  
  
  init(coinsDataService: CoinsDataFetchable) {
    self.coinsDataService = coinsDataService
    addSubscribers()
  }
  
  func addSubscribers() {
    coinDataService.$coins
      .sink { [weak self] returnedcoins in
        self?.coins = returnedcoins
      }
      .store(in: &cancellalbes)
  }
}
