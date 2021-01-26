//
//  BalanceService.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import SwiftUI
import Combine

public protocol BalanceService {
  func getTopics() -> AnyPublisher<[Topic], BalanceError>
  func getQuestions(topicId: Int) -> AnyPublisher<[Question], BalanceError>
}

class BalanceGameService: BalanceService {
  @State var _topics: [Topic] = []
  @State var _questions: [Question] = []
  
  func getTopics() -> AnyPublisher<[Topic], BalanceError> {
    guard _topics.isEmpty else {
      return Just(_topics)
        .mapError { _ -> BalanceError in
          .noTopic
        }
        .eraseToAnyPublisher()
    }
    
    return BalanceAPI.topics()
      .mapError { _ -> BalanceError in
        .noTopic
      }
      .eraseToAnyPublisher()
  }
  
  func getQuestions(topicId: Int) -> AnyPublisher<[Question], BalanceError> {
    #if DEBUG
    let topic = Topic.default
    #else
    if _topics.isEmpty {
      return Fail(error: .noTopic)
        .eraseToAnyPublisher()
    }

    guard let topic = _topics.first(where: { $0.id == topicId }) else {
      return Fail(error: .notMatchTopic)
        .eraseToAnyPublisher()
    }

    guard _questions.isEmpty else {
      return Just(_questions.filter { $0.types.contains(topic.type) }.shuffled())
        .mapError { _ -> BalanceError in
          .noQuestion
        }
        .eraseToAnyPublisher()
    }
    #endif

    return BalanceAPI.questions()
      .handleEvents(receiveOutput: {
                      self._questions = $0
      })
      .map { $0.filter { $0.types.contains(topic.type) }}
      .map { $0.shuffled() }
      .mapError { _ -> BalanceError in
        .noTopic
      }
      .eraseToAnyPublisher()
  }
}
