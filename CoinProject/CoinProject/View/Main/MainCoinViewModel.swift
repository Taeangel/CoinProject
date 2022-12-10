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
  @Published var favoriteCoins: [CoinModel] = []
  
  private var cancellalbes = Set<AnyCancellable>()
  private let favoriteCoinDataService = FavoriteCoinDataService()
  private let coinDataService: CoinsDataFetchable
  
  init(coinDataService: CoinsDataFetchable) {
    self.coinDataService = coinDataService
    addSubscribers()
  }
  
  private func addSubscribers() {
    
    coinDataService.coinsPublisher
      .sink { [weak self] returnedcoins in
        guard let self = self else { return }
        self.coins = returnedcoins ?? []
      }
      .store(in: &cancellalbes)
    
    $searchText
      .combineLatest(coinDataService.coinsPublisher)
      .map(filterCoins)
      .sink { [weak self] returnedCoins in
        guard let self = self else { return }
        self.coins = returnedCoins
      }
      .store(in: &cancellalbes)
    
    $coins
      .combineLatest(favoriteCoinDataService.$saveEntities)
      .map (mapFavoriteCoins)
      .sink { [weak self] returnerCoin in
        self?.favoriteCoins = returnerCoin
      }
      .store(in: &cancellalbes)
  }
  
  func updataFavoriteCoin(coin: CoinModel) {
    favoriteCoinDataService.updateFavoriteCoin(coin: coin)
  }
  
  private func mapFavoriteCoins(coins: [CoinModel], favoriteCoins: [FavoriteCoin]) -> [CoinModel] {
    coins.compactMap { coin -> CoinModel? in
      guard favoriteCoins.first(where: { $0.coinID == coin.id }) != nil else {
        return nil
      }
      return coin.updateHoldings()
    }
  }
  
  private func filterCoins(text: String, coins: [CoinModel]?) -> [CoinModel] {
    guard !text.isEmpty else {
      return coins ?? []
    }
    
    let lowercasedText = text.lowercased()
    
    let filteredCoins = coins?.filter { coin -> Bool in
      return coin.name.lowercased().contains(lowercasedText) ||
      coin.symbol.lowercased().contains(lowercasedText) ||
      coin.id.lowercased().contains(lowercasedText)
    }
    return filteredCoins ?? []
  }
}

