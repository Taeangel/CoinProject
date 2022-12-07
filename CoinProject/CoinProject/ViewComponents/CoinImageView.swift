//
//  CoinImageView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI
import Kingfisher

struct CoinImageView: View {
  let coin: CoinModel
  init(coin: CoinModel) {
    self.coin = coin
  }
  var body: some View {
    ZStack {
      KFImage(coin.coinImageURL)
        .resizable()
        .scaledToFit()
    }
  }
}

struct CoinImageView_Previews: PreviewProvider {
  static var previews: some View {
    CoinImageView(coin: dev.coin)
  }
}
