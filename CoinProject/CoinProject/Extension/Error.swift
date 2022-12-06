//
//  Error.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

extension Error {
  var reflectedString: String {
    return String(reflecting: self)
  }

  func isEqual(to: Self) -> Bool {
    return reflectedString == to.reflectedString
  }
}
