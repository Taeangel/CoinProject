//
//  DetailCoinView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

struct DetailCoinView: View {
  
  @StateObject var vm: DetailCoinViewModel
  
  init(coin: CoinModel) {
    self._vm = StateObject(wrappedValue: DetailCoinViewModel(coin: coin))
  }
  
  var body: some View {
    VStack{
      Text("\(vm.coin.name)")
    }
  }
}

struct DetailCoinView_Previews: PreviewProvider {
  static var previews: some View {
    DetailCoinView(coin: dev.coin)
  }
}
