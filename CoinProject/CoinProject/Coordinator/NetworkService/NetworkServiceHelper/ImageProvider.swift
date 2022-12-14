//
//  ImageProvider.swift
//  CoinProject
//
//  Created by song on 2022/12/15.
//

import Foundation
import Combine

protocol ImageDownloadable {
  func download(url: URL) -> AnyPublisher<Data, Error>
}

struct ImageProvider: ImageDownloadable {
  func download(url: URL) -> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap({ try handleResponse(output: $0, url: url) ?? Data() })
      .retry(3)
      .eraseToAnyPublisher()
  }
  
  private func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data? {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
      return nil
    }
    return output.data
  }
}
