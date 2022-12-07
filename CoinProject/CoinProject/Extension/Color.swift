//
//  Color.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import Foundation
import SwiftUI

extension Color {
  static let theme = ColorTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let blue = Color("BlueColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}
