//
//  LoggingService.swift
//  Logging
//
//  Created by hbkim on 2021/01/26.
//

import os

public enum LogEvent: String {
  case topics
}

public protocol LoggingService {
  func log(event: LogEvent)
  func debug(_ items: Any...)
  func info(_ items: Any...)
  func trace(_ items: Any...)
  func warning(_ items: Any...)
  func error(_ items: Any...)
}

final class FLoggingService: LoggingService {

  func log(event: LogEvent) {
    info(event.rawValue)
  }

  func debug(_ items: Any...) {
    if LoggingModule.logEnvironment.contains(.console) {
      logger.debug("💜 \(self.message(from: items))")
    }
  }

  func info(_ items: Any...) {
    if LoggingModule.logEnvironment.contains(.console) {
      logger.info("💚 \(self.message(from: items))")
    }
  }

  func trace(_ items: Any...) {
    if LoggingModule.logEnvironment.contains(.console) {
      logger.trace("💙 \(self.message(from: items))")
    }
  }

  func warning(_ items: Any...) {
    if LoggingModule.logEnvironment.contains(.console) {
      logger.warning("💛 \(self.message(from: items))")
    }
  }

  func error(_ items: Any...) {
    if LoggingModule.logEnvironment.contains(.console) {
      logger.error("❤️ \(self.message(from: items))")
    }
  }

  private func message(from items: [Any]) -> String {
    return items
      .map { String(describing: $0) }
      .joined(separator: " ")
  }
}
