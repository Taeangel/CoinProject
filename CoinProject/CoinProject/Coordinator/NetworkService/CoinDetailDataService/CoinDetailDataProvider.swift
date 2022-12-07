//
//  CoinDataProvider.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

extension Provider {
  func getCoin(coin: CoinModel) -> AnyPublisher<CoinDetailModel, CoinError> {
    var request = URLRequest(url: coin.coingeckoCoinDetail)
    request.httpMethod = "GET"
    return requestPublisher(request)
  }
}
