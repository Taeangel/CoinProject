//
//  ContentView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

struct MainView: View {
  @ObservedObject var vm: MainCoinViewModel
  @EnvironmentObject var coordinator: Coordinator<coinAppRouter>
  @State private var showFavoriteCoin: Bool = false
  @State private var page: Int = 2
  
  var body: some View {
    VStack(alignment: .leading) {
      
      dataView.padding(.leading)
      
      SearchBarView(seachText: $vm.searchText)
      
      changefavoriteToButton
      
      if showFavoriteCoin {
        favoriteList
      } else {
        allCoinsList
      }
    }
    .onAppear(perform: UIApplication.shared.hideKeyboard)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(vm: MainCoinViewModel(coinDataService: CoinsDataService(), favoriteCoinDataService: FavoriteCoinDataService()))
  }
}

extension MainView {
  private var changefavoriteToButton: some View {
    Button(action: {
      showFavoriteCoin.toggle()
    },
           label: {
      Text(
        showFavoriteCoin ? "toCoin" : "toMyCoin"
      )
    })
  }
  
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
    List(vm.coins) { coin in
      
      HStack {
        CoinRowView(coin: coin)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
          .onTapGesture {
            coordinator.show(.detail(coin))
          }
          .onLongPressGesture {
            vm.updataFavoriteCoin(coin: coin)
          }
          .onAppear {
            if vm.coins.last == coin {
              vm.coinDataService.getCoins(perPage: page)
              page += 1
            }
          }
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var favoriteList: some View {
    List {
      ForEach(vm.favoriteCoins) { coin in
        CoinRowView(coin: coin)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
          .onTapGesture {
            coordinator.show(.detail(coin))
          }
      }
    }
    .listStyle(PlainListStyle())
  }
}

extension CoinModel: Equatable {
  static func == (lhs: CoinModel, rhs: CoinModel) -> Bool {
    return lhs.id == rhs.id
  }
}
