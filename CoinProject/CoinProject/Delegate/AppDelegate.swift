//
//  AppDelegate.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import UIKit

@main
final class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    return true
  }
  
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    let sessionRole = connectingSceneSession.role
    let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
    sceneConfig.delegateClass = SceneDelegate.self
    return sceneConfig
  }
}
