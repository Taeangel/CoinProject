//
//  NavigationRouter.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//

import SwiftUI

protocol NavigationRouter {
  
  associatedtype V: View
  
  var transition: NavigationTranisitionStyle { get }
  
  @ViewBuilder
  func view() -> V
}
