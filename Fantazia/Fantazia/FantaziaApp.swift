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
import FirebaseFirestore

@main
struct FantaziaApp: App {
  @Environment(\.scenePhase) private var scenePhase

  init() {
    FirebaseApp.configure()
    LoggingModule.addEnvironment(.console)
    BalanceModule.setup(with: Self.self)

    let settings = Firestore.firestore().settings
    settings.host = "localhost:8080"
    settings.isPersistenceEnabled = false
    settings.isSSLEnabled = false
    Firestore.firestore().settings = settings
    let db = Firestore.firestore()
    db.collection("topics").getDocuments { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          print("\(document.documentID) => \(document.data())")
        }
      }
    }

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
