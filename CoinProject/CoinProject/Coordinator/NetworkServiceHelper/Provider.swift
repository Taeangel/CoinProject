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
  
  func requestPublisher<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, CoinError> {
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
      print("\(error)")
      print(error.localizedDescription)
    }
  }
}

enum CoinError: Error, Equatable {
  static func == (lhs: CoinError, rhs: CoinError) -> Bool {
    switch (lhs, rhs) {
    case (.network(let lhsError), .network(let rhsError)):
      return ErrorUtility.areEqual(lhsError, rhsError)
    case (.decoding(let lhsError), .decoding(let rhsError)):
      return ErrorUtility.areEqual(lhsError, rhsError)
    default: return false
    }
  }
  
  case network(error: Error)
  case decoding(error: Error)
}

class ErrorUtility {
  public static func areEqual(_ lhs: Error, _ rhs: Error) -> Bool {
    return lhs.reflectedString == rhs.reflectedString
  }
}

public extension Error {
  var reflectedString: String {
    return String(reflecting: self)
  }

  func isEqual(to: Self) -> Bool {
    return reflectedString == to.reflectedString
  }
}

public extension NSError {
  func isEqual(to: NSError) -> Bool {
    let lhs = self as Error
    let rhs = to as Error
    return isEqual(to) && lhs.reflectedString == rhs.reflectedString
  }
}
