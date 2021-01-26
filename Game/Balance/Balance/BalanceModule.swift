//
//  BalanceModule.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/17.
//

import BalanceService
import Logging

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
  
  static func questionsView(topicId: Int) -> QuestionsView {
    QuestionsView(
      viewModel: questionsViewModel(topicId: topicId)
    )
  }
}

extension BalanceModule {
  static func questionsViewModel(topicId: Int) -> QuestionsViewModel {
    QuestionsViewModel(
      topicId: topicId,
      balanceService: BalanceServiceModule.balanceService,
      loggingService: LoggingModule.loggingService
    )
  }
}
