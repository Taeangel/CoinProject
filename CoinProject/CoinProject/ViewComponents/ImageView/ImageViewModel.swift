//
//  ImageViewModel.swift
//  CoinProject
//
//  Created by song on 2022/12/15.
//

import Foundation
import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  @Published var isLoading: Bool = false
  
  private let coin: ImageDownloadableModel
  private let dataService: CoinImageService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: ImageDownloadableModel) {
    self.coin = coin
    self.dataService = CoinImageService(coin: coin, imageDownloader: ImageProvider())
    self.isLoading = true
    addSubscribers()
  }
  
  private func addSubscribers() {
    dataService.$image
      .sink { [weak self] _ in
        self?.isLoading = false
      } receiveValue: { [weak self] returnedImage in
        self?.image = returnedImage
      }
      .store(in: &cancellables)
  }
}
