//
//  CoinDetailDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

protocol CoinDetailDataFetchable {
  var coinDetail: CoinDetailModel? { get }
  var coinDetailValue: Published<CoinDetailModel?> { get }
  var coinDetailPublisher: Published<CoinDetailModel?>.Publisher { get }
  func getCoin()
}

class CoinDetailDataService: CoinDetailDataFetchable {
  
  @Published var coinDetail: CoinDetailModel?
  		
  var coinDetailValue: Published<CoinDetailModel?> {
    return _coinDetail
  }
  
  var coinDetailPublisher: Published<CoinDetailModel?>.Publisher {
    return  $coinDetail
  }
  
  let coin: CoinModel
  private var coinSubscription = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoin()
  }
  
  func getCoin() {
    Provider.shared.getCoin(url: coin.coingeckoCoinDetail)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: Provider.shared.handleCompletion) { [weak self] returnCoins in
        self?.coinDetail = returnCoins
      }
      .store(in: &coinSubscription)
  }
}
