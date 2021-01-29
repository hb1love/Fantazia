//
//  BalanceServiceModule.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Logging

public protocol BalanceServiceConfiguration {
  static var baseUrl: String { get }
}

public class BalanceServiceModule {
  static var config: BalanceServiceConfiguration.Type?
  private static var _config: BalanceServiceConfiguration.Type {
    guard let config = config else {
      preconditionFailure("Please configure BalanceServiceModule before access")
    }
    return config
  }

  static var baseUrl: String = {
    _config.baseUrl
  }()

  public static func setup(with config: BalanceServiceConfiguration.Type) {
    BalanceServiceModule.config = config
  }
}

public extension BalanceServiceModule {
  static var balanceService: BalanceService = {
    BalanceGameService(loggingService: LoggingModule.loggingService)
  }()
}
