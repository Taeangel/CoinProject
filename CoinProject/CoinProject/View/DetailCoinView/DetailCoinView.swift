//
//  DetailCoinView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI
import Kingfisher

struct DetailCoinView: View {
  @StateObject var vm: DetailCoinViewModel
  @EnvironmentObject var coordinator: Coordinator<coinAppRouter>
  
  init(coin: CoinModel) {
    self._vm = StateObject(wrappedValue: DetailCoinViewModel(coin: coin))
  }
  
  var body: some View {
    VStack {
      HStack {
        KFImage(vm.coinDetailService.coinDetail?.imageURL)
          .frame(maxWidth: .infinity, alignment: .leading)
     
        Button(action: {
          coordinator.pop()
        },
               label: {
          Text("백버튼입니다.")
        })
       
      }
      
      DetailChartView(sevenDaysHaveModel: vm.coin)
      
      infoSection
      
      webSiteSection
    }
  }
}

struct DetailCoinView_Previews: PreviewProvider {
  static var previews: some View {
    DetailCoinView(coin: dev.coin)
  }
}

extension DetailCoinView {
  private var webSiteSection: some View {
    VStack(alignment: .leading, spacing: 101) {
      if let websiteString = vm.websiteURL, let url = URL(string: websiteString) {
        Link("Website", destination: url)
      }
    }
    .tint(.blue)
    .frame(maxWidth: .infinity, alignment: .leading)
    .font(.headline)
  }
  
  private var infoSection: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("currentPrice: \(vm.currentPrice ?? "")")
          .foregroundColor(Color.theme.secondaryText)
          .font(.callout)
        Text("marketCap: \(vm.marketCap ?? "")")
          .foregroundColor(Color.theme.secondaryText)
          .font(.callout)
      }
      VStack(alignment: .leading) {
        Text("lowPrice: \(vm.lowPrice ?? "")")
          .foregroundColor(Color.theme.secondaryText)
          .font(.callout)
        Text("highPrice: \(vm.highPrice ?? "")")
          .foregroundColor(Color.theme.secondaryText)
          .font(.callout)
      }
    }
  }
}
