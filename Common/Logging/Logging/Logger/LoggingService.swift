//
//  LoggingService.swift
//  Logging
//
//  Created by hbkim on 2021/01/26.
//

import os

public enum LogEvent: String {
  case topics
  case topic
}

public protocol LoggingService {
  func event(_ event: LogEvent)
  func debug(_ items: Any...)
  func info(_ items: Any...)
  func trace(_ items: Any...)
  func warning(_ items: Any...)
  func error(_ items: Any...)
}

final class FLoggingService: LoggingService {

  let logger = Logger()

  func event(_ event: LogEvent) {
    info(event.rawValue)
  }

  func debug(_ items: Any...) {
    let message = self.message(from: items, prefix: "💙")
    if LoggingModule.logEnvironment.contains(.console) {
      logger.debug("\(message)")
    }
  }

  func info(_ items: Any...) {
    let message = self.message(from: items, prefix: "💚")
    if LoggingModule.logEnvironment.contains(.console) {
      logger.info("\(message)")
    }
  }

  func trace(_ items: Any...) {
    let message = self.message(from: items, prefix: "💜")
    if LoggingModule.logEnvironment.contains(.console) {
      logger.trace("\(message)")
    }
  }

  func warning(_ items: Any...) {
    let message = self.message(from: items, prefix: "💛")
    if LoggingModule.logEnvironment.contains(.console) {
      logger.warning("\(message)")
    }
  }

  func error(_ items: Any...) {
    let message = self.message(from: items, prefix: "❤️")
    if LoggingModule.logEnvironment.contains(.console) {
      logger.error("\(message)")
    }
  }

  private func message(from items: [Any], prefix: String) -> String {
    [prefix, message(from: items)].joined(separator: " ")
  }

  private func message(from items: [Any]) -> String {
    items
      .map { String(describing: $0) }
      .joined(separator: " ")
  }
}
