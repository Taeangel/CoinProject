//
//  SceneDelegate.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
  
  private let coordinator: Coordinator<coinAppRouter> = .init(startingRoute: .main)
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = coordinator.navigationController
    window?.makeKeyAndVisible()
    coordinator.start()
  }
}
