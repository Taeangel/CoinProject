//
//  UIApplication.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import UIKit

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
