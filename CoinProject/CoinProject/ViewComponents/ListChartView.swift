//
//  ChartView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

struct ListChartView: View {
  private let data: [Double]
  private let maxY: Double
  private let minY: Double
  private let lineColor: Color
  
  init(sevenDaysHaveModel: SevenDaysHaveable) {
    self.data = sevenDaysHaveModel.sevenDatas
    maxY = sevenDaysHaveModel.maxPrice
    minY = sevenDaysHaveModel.minPrice
    
    lineColor = sevenDaysHaveModel.priceChange > 0 ? Color.theme.blue : Color.theme.red
  }
  
  var body: some View {
    VStack {
      ZStack{
        chartView
          .frame(height: 50)
        chartStandardView
          .frame(height: 50)
      }
    }
    .font(.caption)
  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
    ListChartView(sevenDaysHaveModel: dev.coin)
  }
}

extension ListChartView {
  private var chartView: some View {
    GeometryReader { geometry in
      Path { path in
        for index in data.indices {
          let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
          
          let yAxis = maxY - minY
          
          let yPosition = (1 - CGFloat((data[index] - minY) / yAxis )) * geometry.size.height
          
          if index == 0 {
            path.move(to: CGPoint(x: xPosition, y: yPosition))
          }
          path.addLine(to: CGPoint(x: xPosition, y: yPosition))
        }
      }
      .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
      .shadow(color: lineColor, radius: 10, x: 0.0, y: 1)
    }
  }
  
  private var chartStandardView: some View {
    GeometryReader { geometry in
      Path { path in
        guard let startingPrice = data.first else {
          return
        }
        
        for index in data.indices {
          let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
          
          let yAxis = maxY - minY
          
          let yPosition = (1 - CGFloat((startingPrice - minY) / yAxis )) * geometry.size.height
          
          if index == 0 {
            path.move(to: CGPoint(x: xPosition, y: yPosition))
          }
          path.addLine(to: CGPoint(x: xPosition, y: yPosition))
        }
      }
      .stroke(lineColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
    }
  }
}
