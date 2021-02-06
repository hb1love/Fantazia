//
//  BalanceModule.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/17.
//

import SwiftUI
import BalanceService
import Logging
import Resource

public protocol BalanceConfiguration: BalanceServiceConfiguration {}

public class BalanceModule {
  static var config: BalanceConfiguration.Type?
  private static var _config: BalanceConfiguration.Type {
    guard let config = config else {
      preconditionFailure("Please configure BalanceModule before access")
    }
    return config
  }

  public static func setup(with config: BalanceConfiguration.Type) {
    Font.loadAllFonts()
    BalanceModule.config = config
    BalanceServiceModule.setup(with: config)
    LoggingModule.addEnvironment(.console)
  }
}

public extension BalanceModule {
  static func topicView() -> TopicsView {
    TopicsView(
      viewModel: TopicsViewModel(
        balanceService: BalanceServiceModule.balanceService,
        loggingService: LoggingModule.loggingService
      )
    )
  }
  
  static func questionsView(topic: Topic) -> QuestionsView {
    QuestionsView(
      viewModel: questionsViewModel(topic: topic)
    )
  }
}

extension BalanceModule {
  static func questionsViewModel(topic: Topic) -> QuestionsViewModel {
    QuestionsViewModel(
      topic: topic,
      balanceService: BalanceServiceModule.balanceService,
      loggingService: LoggingModule.loggingService
    )
  }
}
