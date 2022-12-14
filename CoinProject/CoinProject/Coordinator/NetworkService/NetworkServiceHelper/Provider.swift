//
//  Provider.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import Combine

struct Provider {
  static let shared = Provider()
  private init() {}
  
  func getCoin<T: Codable>(url: URL) -> AnyPublisher<T, CoinError> {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    return requestPublisher(request)
  }
  
  private func requestPublisher<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, CoinError> {
    URLSession.shared.dataTaskPublisher(for: request)
      .mapError { .network(error: $0) }
      .flatMap { self.requestDecoder(data: $0.data) }
      .eraseToAnyPublisher()
  }
  
  private func requestDecoder<T: Codable>(data: Data) -> AnyPublisher<T, CoinError> {
    return Just(data)
      .tryMap { try JSONDecoder().decode(T.self, from: $0) }
      .mapError { .decoding(error: $0) }
      .eraseToAnyPublisher()
  }

  func handleCompletion(completion: Subscribers.Completion<CoinError>) {
    switch completion {
    case .finished:
      break
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}





