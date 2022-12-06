//
//  Date.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

extension Date {
  
  init(coinGeckoString: String) {
    
    let fornatter = DateFormatter()
    fornatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = fornatter.date(from: coinGeckoString)
    self.init(timeInterval: 0, since: date ?? Date())
  }
  
  var dateKorean: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "M월 d일"
    return dateformmater.string(from: self)
  }
  
  private var shoetFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  
  func asShortDateString() -> String {
    return shoetFormatter.string(from: self)
  }
}
