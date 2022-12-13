//
//  DetailCoinViewModel.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

class DetailCoinViewModel: ObservableObject {
  
  @Published var coin: CoinModel
  @Published var websiteURL: String?
  @Published var currentPrice: String?
  @Published var marketCap: String?
  @Published var lowPrice: String?
  @Published var highPrice: String?
  @Published var description: String?
  
  let coinDetailService: CoinDetailDataFetchable
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coin = coin
    self.coinDetailService = CoinDetailDataService(coin: coin)
    addSubscriptions()
  }
  
  private func addSubscriptions() {
    coinDetailService.coinDetailPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] returnedCoinDetail in
        guard let self = self else { return }
        self.websiteURL = returnedCoinDetail?.links?.homepage?.first
        self.description = returnedCoinDetail?.welcomeDescription?.en
      }
      .store(in: &cancellables)
    
    $coin
      .sink { [weak self] returnedCoinModel in
        guard let self = self else { return }
        self.currentPrice = returnedCoinModel.currentPrice.asCurrencyWith2Decimals()
        self.marketCap = returnedCoinModel.marketCap?.formattedWithAbbreviations()
        self.lowPrice = returnedCoinModel.minPrice.asCurrencyWith2Decimals()
        self.highPrice = returnedCoinModel.maxPrice.asCurrencyWith2Decimals()
        
      }
      .store(in: &cancellables)
  }
}
