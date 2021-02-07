//
//  SceneDelegate.swift
//  Fantazia
//
//  Created by hbkim on 2021/02/07.
//

import UIKit
import SwiftUI
import Balance

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: BalanceModule.topicView())
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
