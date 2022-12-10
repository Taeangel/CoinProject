//
//  FavoriteCoinDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/08.
//

import Foundation
import CoreData

protocol FavoriteCoinDataServiceFetchable {
  func updateFavoriteCoin(coin: CoinModel)
  var savedEntities: [FavoriteCoin] { get }
  var savedEntitiesValue: Published<[FavoriteCoin]> { get }
  var savedEntitiesPublisher: Published<[FavoriteCoin]>.Publisher { get }
}

class FavoriteCoinDataService: FavoriteCoinDataServiceFetchable {
  
  @Published var savedEntities: [FavoriteCoin] = []
  
  var savedEntitiesValue: Published<[FavoriteCoin]> {
    return _savedEntities
  }
  
  var savedEntitiesPublisher: Published<[FavoriteCoin]>.Publisher {
    return $savedEntities
  }
  
  
  private let container: NSPersistentContainer
  private let containerName: String = "FavoriteCoinContainer"
  private let entityName: String = "FavoriteCoin"
  
  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading \(error)")
      }
      self.getPortfolio()
    }
  }

    func updateFavoriteCoin(coin: CoinModel) {
      if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
        delete(entity: entity)
      } else {
        add(coin: coin)
      }
    }
  
  private func getPortfolio() {
    let request = NSFetchRequest<FavoriteCoin>(entityName: entityName)
    
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching Portfolio Entities \(error)")
    }
  }
  
  private func add(coin: CoinModel) {
    let entity = FavoriteCoin(context: container.viewContext)
    entity.coinID = coin.id
    applyChanges()
  }
  
  private func delete(entity: FavoriteCoin) {
    container.viewContext.delete(entity)
    applyChanges()
  }
  
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch let error {
      print("Error saving to Core Data. \(error)")
    }
  }
  
  private func applyChanges() {
    save()
    getPortfolio()
  }
}
