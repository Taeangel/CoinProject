//
//  CoinsDataProvider.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

extension Provider {
  var coingeckoUrl: URL {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
      return URL(fileURLWithPath: "")
    }
    return url
  }
  
  func getCoins() -> AnyPublisher<[CoinModel], CoinError> {
    
    var request = URLRequest(url: coingeckoUrl)
    request.httpMethod = "GET"

    return requestPublisher(request)
  }
}
