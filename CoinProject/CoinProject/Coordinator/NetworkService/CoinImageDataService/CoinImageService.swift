//
//  CoinImageService.swift
//  CoinProject
//
//  Created by song on 2022/12/15.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {

  @Published var image: UIImage? = nil

  private var coinSubscription: AnyCancellable?
  private var coinURL: URL
  private let fileManager = LocalFileManager.instance
  private let cacheManager = CacheManager.instance
  private var folerName = "coin_images"
  private let imageName: String
  private let imageDownloader: ImageDownloadable

  init(coin: ImageDownloadableModel, imageDownloader: ImageDownloadable) {
    self.coinURL = coin.imageURL
    self.imageName = coin.id
    self.imageDownloader = imageDownloader
    getCoinImage()
  }

  private func getCoinImage() {
    
    if let cachedImage = cacheManager.get(key: imageName) {
      image = cachedImage
    } else if let fileSavedImage = fileManager.getImage(imageName: imageName, folderName: folerName) {
      image = fileSavedImage
    } else {
      downloadCoinImage()
    }
  }

  private func downloadCoinImage() {
    coinSubscription = imageDownloader.download(url: coinURL)
      .tryMap({ data -> UIImage? in

        return UIImage(data: data)
      })
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { _ in
       
      }, receiveValue: { [weak self] returnedImage in
        guard let self = self, let returnedImage = returnedImage else { return }
        self.image = returnedImage
        self.cacheManager.add(key: self.imageName, value: returnedImage)
        self.fileManager.saveImage(image: returnedImage, imageName: self.imageName, folderName: self.folerName)
        self.coinSubscription?.cancel()
      })
  }
}
