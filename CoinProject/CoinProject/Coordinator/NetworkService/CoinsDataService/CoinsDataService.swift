//
//  CoinDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

protocol CoinsDataFetchable {
  func getCoins(perPage: Int)
  var coins: [CoinModel] { get }
  var coinsValue: Published<[CoinModel]> { get }
  var coinsPublisher: Published<[CoinModel]>.Publisher { get }
}

class CoinsDataService: CoinsDataFetchable {
  @Published var coins: [CoinModel]
  
  var coinsValue: Published<[CoinModel]> {
    return _coins
  }
  
  var coinsPublisher: Published<[CoinModel]>.Publisher {
    return $coins
  }
  
  private var coinSubscription = Set<AnyCancellable>()
  
  init() {
    self.coins = []
    getCoins(perPage: 1)
  }
  
  func getCoins(perPage: Int) {
    Provider.shared.requestPublisher(CoinRouter.getCoins(per_page: perPage).asURLRequest())
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: Provider.shared.handleCompletion) { [weak self] returnCoins in
        self?.coins += returnCoins
      }
      .store(in: &coinSubscription)
  }
}
