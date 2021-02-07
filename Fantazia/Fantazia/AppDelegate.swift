//
//  AppDelegate.swift
//  Fantazia
//
//  Created by hbkim on 2021/02/07.
//

import UIKit
import Balance
import BalanceService
import Logging
import Core
import Resource
import Firebase
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UIFont.loadAllFonts()
    FirebaseApp.configure()
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    LoggingModule.addEnvironment(.console)
    BalanceModule.setup(with: Self.self)
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}

extension AppDelegate: BalanceConfiguration, BalanceServiceConfiguration {
  static let baseUrl: String = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String

  static let adUnitId: String = Bundle.main.object(forInfoDictionaryKey: "GAD_UNIT_ID") as! String
}
