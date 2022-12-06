//
//  CoinError.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

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
