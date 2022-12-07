//
//  String.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

extension String {
  
  var removingHTMLOccurances: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
