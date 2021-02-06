//
//  BalanceService.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import SwiftUI
import Combine
import Logging

public protocol BalanceService {
  func getTopics() -> AnyPublisher<[Topic], BalanceError>
  func getQuestions(topic: Topic) -> AnyPublisher<[Question], BalanceError>
}

class BalanceGameService: BalanceService {
  @State var _topics: [Topic] = []

  private let loggingService: LoggingService

  init(loggingService: LoggingService) {
    self.loggingService = loggingService
  }
  
  func getTopics() -> AnyPublisher<[Topic], BalanceError> {
    guard _topics.isEmpty else {
      return Just(_topics)
        .mapError { _ -> BalanceError in
          .noTopic
        }
        .eraseToAnyPublisher()
    }
    
    return BalanceAPI.topics()
      .handleEvents(receiveOutput: {
        self._topics = $0
      })
      .mapError { error -> BalanceError in
        .request(reason: error)
      }
      .eraseToAnyPublisher()
  }
  
  func getQuestions(topic: Topic) -> AnyPublisher<[Question], BalanceError> {
    return BalanceAPI.topic(id: topic.id)
      .map { (topic: Topic) -> [Question] in
        return topic.questions
      }
      .map { $0.shuffled() }
      .mapError { _ -> BalanceError in
        self.loggingService.error(BalanceError.noTopic)
        return .noTopic
      }
      .eraseToAnyPublisher()
  }
}
