//
//  CoinImageView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

struct ImageView: View {
  @StateObject private var vm: ImageViewModel

  
  init(coin: ImageDownloadableModel) {
    _vm = StateObject(wrappedValue: ImageViewModel(coin: coin))
  }
  
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else if vm.isLoading {
        ProgressView()
      } else {
        Image(systemName: "questionmark")
          .foregroundColor(Color.theme.secondaryText)
      }
    }
  }
}

struct CoinImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView(coin: dev.coin)
  }
}
