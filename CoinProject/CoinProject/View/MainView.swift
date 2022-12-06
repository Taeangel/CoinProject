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
      Text("코인")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.theme.accent)
      
      Text("\(Date().dateKorean)")
        .font(.headline)
        .fontWeight(.bold)
        .foregroundColor(Color.theme.accent)
      
      SearchBarView(seachText: $vm.searchText)

      Spacer()
      
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(vm: MainCoinViewModel(coinsDataService: CoinsDataService()))
  }
}
