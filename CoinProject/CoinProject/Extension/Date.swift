//
//  Date.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation

extension Date {
  var dateKorean: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "M월 d일"
    return dateformmater.string(from: self)
  }
}
