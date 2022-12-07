//
//  DetailChartView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

struct DetailChartView: View {
  
  private let data: [Double]
  private let maxY: Double
  private let minY: Double
  private let lineColor: Color
  private let daysNumbers: [String] = ["1","2","3","4","5","6","7"]
  
  @State private var percentage: CGFloat = 0
  
  init(sevenDaysHaveModel: SevenDaysHaveable) {
    self.data = sevenDaysHaveModel.sevenDatas
    maxY = data.max() ?? 0
    minY = data.min() ?? 0
    
    lineColor = sevenDaysHaveModel.priceChange > 0 ? Color.theme.green : Color.theme.red
  }
  
  var body: some View {
    VStack {
      Text("OneWeek")
      
      chartView
        .frame(height: 200)
        .background(chartBackGround)
        .overlay(alignment: .leading) {
          chartYAxisView
            .padding(.horizontal, 4)
            .foregroundColor(Color.theme.accent)
        }
      
      chartDateLabel
      
    }
    .font(.caption)
    .foregroundColor(Color.theme.secondaryText)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now()) {
        withAnimation(.linear(duration: 2.0)) {
          percentage = 1.0
        }
      }
    }
  }
}

struct Detail_Previews: PreviewProvider {
  static var previews: some View {
    DetailChartView(sevenDaysHaveModel: dev.coin)
  }
}


extension DetailChartView {
  private var chartView: some View {
    GeometryReader { geometry in
      Path { path in
        for index in data.indices {
          let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
          
          let yAxis = maxY - minY
          
          let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
          
          if index == 0 {
            path.move(to: CGPoint(x: xPosition, y: yPosition))
          }
          path.addLine(to: CGPoint(x: xPosition, y: yPosition))
        }
      }
      .trim(from: 0, to: percentage)
      .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
      .shadow(color: lineColor, radius: 10, x: 0.0, y: 1)
    }
  }
  
  private var chartBackGround: some View {
    VStack {
      Divider()
      Spacer()
      Divider()
      Spacer()
      Divider()
    }
  }
  
  private var chartYAxisView: some View {
    VStack {
      Text(maxY.formattedWithAbbreviations())
      Spacer()
      Text(minY.formattedWithAbbreviations())
    }
  }
  
  private var chartDateLabel: some View {
    HStack {
      ForEach(daysNumbers, id:\.self) { day in
        if day.count != 7 {
          Text("\(day)")
          Spacer()
        }
      }
    }
  }
}
