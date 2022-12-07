//
//  CoinImageView.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
  let imageDownloadable: ImageDownloadableModel
  
  init(url: ImageDownloadableModel) {
    self.imageDownloadable = url
  }
  
  var body: some View {
    ZStack {
      KFImage(imageDownloadable.imageURL)
        .resizable()
        .scaledToFit()
    }
  }
}

struct CoinImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView(url: dev.coin)
  }
}
