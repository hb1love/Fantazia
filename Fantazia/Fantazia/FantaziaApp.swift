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
import Resource
import Firebase
//import GoogleMobileAds

@main
struct FantaziaApp: App {
  @Environment(\.scenePhase) private var scenePhase

  init() {
    Font.loadAllFonts()
    FirebaseApp.configure()
//    GADMobileAds.sharedInstance().start(completionHandler: nil)
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
        log.info("scene is now active!")
      case .inactive:
        log.info("scene is now inactive!")
      case .background:
        log.info("scene is now in the background!")
      @unknown default:
        log.info("Apple must have added something new!")
      }
    }
  }
}

extension FantaziaApp: BalanceConfiguration, BalanceServiceConfiguration {
  static var baseUrl: String {
    #if DEBUG
    return "http://ec2-13-125-208-107.ap-northeast-2.compute.amazonaws.com:8080/api"
    #else
    return "http://ec2-13-125-208-107.ap-northeast-2.compute.amazonaws.com:8080/api"
    #endif
  }
}
