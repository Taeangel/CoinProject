//
//  CoinRowView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//
import SwiftUI

struct CoinRowView: View {
  
  let coin: CoinModel
  
  var body: some View {
    
    HStack {
      
      leftColumn
      
      Spacer()
      
      ListChartView(sevenDaysHaveModel: coin)
        .padding(.leading, 20)
      
      rightCoulmn
      
    }
    .font(.subheadline)
    .background(Color.theme.background)
  }
}

struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CoinRowView(coin: dev.coin)
        .previewLayout(.fixed(width: 200, height: 200))
      
      CoinRowView(coin: dev.coin)
        .previewLayout(.sizeThatFits)
      CoinRowView(coin: dev.coin)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
  }
}

extension CoinRowView {
  
  private var leftColumn: some View {
    HStack(spacing: 0) {
      ImageView(coin: coin)
        .frame(width: 30)
      
      Text(coin.symbol.uppercased())
        .font(.headline)
        .padding(.leading, 6)
        .foregroundColor(Color.theme.accent)
    }
  }
  
  private var rightCoulmn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentPrice.asCurrencyWith2Decimals())
        .bold()
        .foregroundColor(Color.theme.accent)
      Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
        .foregroundColor(
          (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.blue : Color.theme.red
        )
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}
