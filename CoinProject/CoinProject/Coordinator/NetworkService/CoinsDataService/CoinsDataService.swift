//
//  CoinDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

protocol CoinsDataFetchable {
  func getCoins()
  var coins: [CoinModel]? { get }
  var coinsValue: Published<[CoinModel]?> { get }
  var coinsPublisher: Published<[CoinModel]?>.Publisher { get }
}

class CoinsDataService: CoinsDataFetchable {
  @Published var coins: [CoinModel]?
  
  var coinsValue: Published<[CoinModel]?> {
    return _coins
  }
  
  var coinsPublisher: Published<[CoinModel]?>.Publisher {
    return $coins
  }
  
  var coingeckoUrl: URL {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=150&page=1&sparkline=true&price_change_percentage=24h") else {
      return URL(fileURLWithPath: "")
    }
    return url
  }
  
  private var coinSubscription = Set<AnyCancellable>()
  
  init() {
    getCoins()
  }
  
  func getCoins() {
    Provider.shared.getCoin(url: coingeckoUrl)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: Provider.shared.handleCompletion) { [weak self] returnCoins in
        self?.coins = returnCoins
      }
      .store(in: &coinSubscription)
  }
}
