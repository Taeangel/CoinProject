//
//  ErrorUtility.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

class ErrorUtility {
  static func areEqual(_ lhs: Error, _ rhs: Error) -> Bool {
    return lhs.reflectedString == rhs.reflectedString
  }
}
