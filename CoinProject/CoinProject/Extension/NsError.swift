//
//  NsError.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

extension NSError {
  func isEqual(to: NSError) -> Bool {
    let lhs = self as Error
    let rhs = to as Error
    return isEqual(to) && lhs.reflectedString == rhs.reflectedString
  }
}
