//
//  BalanceApp.swift
//  BalanceApp
//
//  Created by hbkim on 2021/01/27.
//

import SwiftUI
import Balance
import Logging

@main
struct BalanceApp: App {
  @Environment(\.scenePhase) private var scenePhase

  init() {
    LoggingModule.addEnvironment(.console)
    BalanceModule.setup(with: Self.self)
  }

  var body: some Scene {
    WindowGroup {
      BalanceModule.topicView()
      //      BalanceUIModule.makeQuestionsView(topicId: 1)
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

extension BalanceApp: BalanceConfiguration {
  static var baseUrl: String {
    ""
  }
}
