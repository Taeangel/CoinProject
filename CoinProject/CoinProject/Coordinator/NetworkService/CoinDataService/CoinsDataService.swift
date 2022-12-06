//
//  CoinDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

class CoinsDataService {
  
  @Published var Coins: [CoinModel] = []
  private var coinSubscription = Set<AnyCancellable>()

  init() {
    getCoins()
  }
 
  func getCoins() {
    Provider.shared.getCoins()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: Provider.shared.handleCompletion) { [weak self] returnCoins in
        self?.Coins = returnCoins
      }
      .store(in: &coinSubscription)
  }
}


