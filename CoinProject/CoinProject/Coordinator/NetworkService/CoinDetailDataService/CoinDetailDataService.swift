//
//  CoinDetailDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

protocol CoinDetailDataFetchable {
  func getCoin()
  var coin: CoinModel { get }
}

class CoinDetailDataService: CoinDetailDataFetchable {
  @Published var coinDetail: CoinDetailModel?
  let coin: CoinModel
  private var coinSubscription = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoin()
  }
  
  func getCoin() {
    Provider.shared.getCoin(coin: coin)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: Provider.shared.handleCompletion) { [weak self] returnCoins in
        self?.coinDetail = returnCoins
      }
      .store(in: &coinSubscription)
  }
}
