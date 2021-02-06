//
//  LoggingModule.swift
//  Logging
//
//  Created by hbkim on 2021/01/26.
//

import os

public let log = LoggingModule.loggingService

public class LoggingModule {
  static var logEnvironment: [LogEnvironment] = [.console]

  public static func addEnvironment(_ env: LogEnvironment...) {
    LoggingModule.logEnvironment = env
  }
}

public extension LoggingModule {
  static var loggingService: LoggingService = FLoggingService()
}
