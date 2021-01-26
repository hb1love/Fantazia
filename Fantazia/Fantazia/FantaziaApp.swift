//
//  FantaziaApp.swift
//  Fantazia
//
//  Created by hbkim on 2021/01/26.
//

import SwiftUI
import Balance
import BalanceService
import Logging
import Core
import Firebase

@main
struct FantaziaApp: App {
  @Environment(\.scenePhase) private var scenePhase

  init() {
    FirebaseApp.configure()
    LoggingModule.addEnvironment(.console)
    BalanceModule.setup(with: Self.self)

  }

  var body: some Scene {
    WindowGroup {
      BalanceModule.topicView()
    }
    .onChange(of: scenePhase) { (newScenePhase) in
      switch newScenePhase {
      case .active:
        logger.info("scene is now active!")
      case .inactive:
        logger.info("scene is now inactive!")
      case .background:
        logger.info("scene is now in the background!")
      @unknown default:
        logger.info("Apple must have added something new!")
      }
    }
  }
}

extension FantaziaApp: BalanceConfiguration, BalanceServiceConfiguration {
  static var baseUrl: String {
    ""
  }
}
