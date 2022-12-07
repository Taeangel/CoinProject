//
//  ContentView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

struct MainView: View {
  @ObservedObject var vm: MainCoinViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    VStack(alignment: .leading) {
      titleView
      
      dataView
      
      SearchBarView(seachText: $vm.searchText)

      allCoinsList
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(vm: MainCoinViewModel(coinsDataService: CoinsDataService()))
  }
}

extension MainView {
  
  private var titleView: some View {
    Text("코인")
      .font(.headline)
      .fontWeight(.heavy)
      .foregroundColor(Color.theme.accent)
  }
  
  private var dataView: some View {
    Text("\(Date().dateKorean)")
      .font(.headline)
      .fontWeight(.bold)
      .foregroundColor(Color.theme.accent)
  }
  
  private var allCoinsList: some View {
    List {
      ForEach(vm.coins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
          .onTapGesture {
            coordinator.show(.detail(coin))
          }
      }
    }
    .listStyle(PlainListStyle())
  }
}
