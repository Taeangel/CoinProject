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
  @Published var sortOption: SortOption = .holdings
  
  private let coinsDataService = CoinsDataService()
  private var cancellalbes = Set<AnyCancellable>()
  var coinDataService = CoinsDataService()
  
  
  init(coinsDataService: CoinsDataFetchable) {
    addSubscribers()
  }
  
  private func addSubscribers() {
    
    coinDataService.$coins
      .sink { [weak self] returnedcoins in
        self?.coins = returnedcoins
      }
      .store(in: &cancellalbes)
    
    $searchText
      .combineLatest(coinsDataService.$coins, $sortOption)
      .map(filterAndSortCoins)
      .sink { [weak self] returnedCoins in
        guard let self = self else { return }
        self.coins = returnedCoins
      }
      .store(in: &cancellalbes)
  }
  
  enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
  }
  
  private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
    var filteredCoin = filterCoins(text: text, coins: coins)
    sortCoins(sort: sort, coins: &filteredCoin)
    return filteredCoin
  }
  
  private func sortCoins(sort: SortOption, coins: inout [CoinModel]){
    switch sort {
    case .rank:
      coins.sort { $0.rank < $1.rank }
    case .rankReversed:
      coins.sort { $0.rank > $1.rank }
    case .holdings:
      coins.sort { $0.rank < $1.rank }
    case .holdingsReversed:
      coins.sort { $0.rank > $1.rank }
    case .price:
      coins.sort { $0.currentPrice > $1.currentPrice }
    case .priceReversed:
      coins.sort { $0.currentPrice < $1.currentPrice }
    }
  }
  
  private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
      return coins
    }
    
    let lowercasedText = text.lowercased()
    
    let filteredCoins = coins.filter { coin -> Bool in
      return coin.name.lowercased().contains(lowercasedText) ||
      coin.symbol.lowercased().contains(lowercasedText) ||
      coin.id.lowercased().contains(lowercasedText)
    }
    return filteredCoins
  }
}
