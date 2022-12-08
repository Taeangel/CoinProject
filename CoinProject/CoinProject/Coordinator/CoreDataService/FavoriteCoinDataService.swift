//
//  FavoriteCoinDataService.swift
//  CoinProject
//
//  Created by song on 2022/12/08.
//

import Foundation
import CoreData

class FavoriteCoinDataService {
  
  private let container: NSPersistentContainer
  private let containerName: String = "FavoriteCoinContainer"
  private let entityName: String = "FavoriteCoin"
  
  @Published var saveEntities: [FavoriteCoin] = []
  
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
      if let entity = saveEntities.first(where: { $0.coinID == coin.id }) {
        delete(entity: entity)
      } else {
        add(coin: coin)
      }
    }
  
  private func getPortfolio() {
    let request = NSFetchRequest<FavoriteCoin>(entityName: entityName)
    
    do {
      saveEntities = try container.viewContext.fetch(request)
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
