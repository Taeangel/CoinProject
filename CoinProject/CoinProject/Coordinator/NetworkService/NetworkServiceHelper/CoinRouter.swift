//
//  CoinRouter.swift
//  CoinProject
//
//  Created by song on 2022/12/16.
//

import Foundation
//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=150&page=1&sparkline=true&price_change_percentage=24h
//https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false

enum CoinRouter {

  var BaseURLString: String {
    return "https://api.coingecko.com/api/v3/coins/"
  }
  
  case getCoins(vs_currency: String = "usd", order: String = "market_cap_desc", per_page: Int = 1, page: Int = 20, sparkline: String = "true", price_change_percentage: String = "24h")
  
  case getCoin(id: String, localization: Bool = false, tickers: Bool = false, market_data : Bool = false, community_data: Bool = false, developer_data: Bool = false, sparkline: Bool = false)
  
  var endPoint: String {
    switch self {
    case .getCoins:
      return "markets?"
    case .getCoin:
      return ""
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getCoins:
      return .get
    case .getCoin:
      return .get
    }
  }
  
  var parameters: [String: Any] {
    switch self {
    case let .getCoins(vs_currency, order, page, per_page, sparkline, price_change_percentage):
      var params: [String: Any] = [:]
      params["vs_currency"] = vs_currency
      params["order"] = order
      params["per_page"] = per_page
      params["page"] = page
      params["sparkline"] = sparkline
      params["price_change_percentage"] = price_change_percentage
      return params
    case let .getCoin(id,localization,tickers,market_data,community_data,developer_data,sparkline):
      var params: [String: Any] = [:]
      params["id"] = id
      params["localization"] = localization
      params["tickers"] = tickers
      params["market_data"] = market_data
      params["community_data"] = community_data
      params["developer_data"] = developer_data
      params["sparkline"] = sparkline
      return params
     }
  }
  
  func asURLRequest() -> URLRequest {
    
    var components = URLComponents(string: BaseURLString + endPoint)
    
    components?.queryItems = parameters.map { key, value in
      URLQueryItem(name: key, value: "\(value)")
    }

    var request = URLRequest(url: (components?.url)!)
    request.httpMethod = method.rawValue
    
    return request
  }
}
