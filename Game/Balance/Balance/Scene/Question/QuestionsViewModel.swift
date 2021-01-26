//
//  QuestionsViewModel.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/25.
//

import Combine
import BalanceService
import Logging

final class QuestionsViewModel: ObservableObject, Identifiable {
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Input
  enum Input {
    case onAppear
    case onNext
    case onPrev
  }
  
  func apply(_ input: Input) {
    switch input {
    case .onAppear: onAppearSubject.send()
    case .onNext: onNextSubject.send()
    case .onPrev: onPrevSubject.send()
    }
  }
  private let onAppearSubject = PassthroughSubject<Void, Never>()
  private let onNextSubject = PassthroughSubject<Void, Never>()
  private let onPrevSubject = PassthroughSubject<Void, Never>()
  
  // MARK: - Output
  @Published var dataSource: [Question] = []
  @Published var question: Question = .default
  @Published var errorMessage = ""
  var order: Int = 0
  
  private let responseSubject = PassthroughSubject<[Question], Never>()
  private let errorSubject = PassthroughSubject<BalanceError, Never>()
  private let trackingSubject = PassthroughSubject<LogEvent, Never>()
  
  private let topicId: Int
  private let balanceService: BalanceService
  private let loggingService: LoggingService
  init(
    topicId: Int,
    balanceService: BalanceService,
    loggingService: LoggingService
  ) {
    self.topicId = topicId
    self.balanceService = balanceService
    self.loggingService = loggingService
    
    bindInputs()
    bindOutputs()
  }
  
  private func bindInputs() {
    let responsePublisher = onAppearSubject
      .flatMap { [balanceService] _ in
        balanceService.getQuestions(topicId: self.topicId)
          .catch { [weak self] error -> Empty<[Question], Never> in
            self?.errorSubject.send(error)
            return .init()
          }
      }

    responsePublisher
      .share()
      .subscribe(responseSubject)
      .store(in: &cancellables)
    
    onNextSubject
      .sink(receiveValue: nextQuestion)
      .store(in: &cancellables)
    
    onPrevSubject
      .sink(receiveValue: prevQuestion)
      .store(in: &cancellables)
    
    onAppearSubject
      .map { .topics }
      .subscribe(trackingSubject)
      .store(in: &cancellables)
    
    trackingSubject
      .sink(receiveValue: loggingService.log)
      .store(in: &cancellables)
  }
  
  private func bindOutputs() {
    responseSubject
      .handleEvents(receiveOutput: updateDateSource)
      .map { _ in }
      .subscribe(onNextSubject)
      .store(in: &cancellables)
    
    errorSubject
      .map { error -> String in
        switch error {
        case .request: return "일시적인 오류입니다. 잠시후에 다시 시도해주세요."
        case .noTopic, .notMatchTopic, .noQuestion:
          return "앱 재시작 후에 다시 시도해주세요."
        }
      }
      .assign(to: \.errorMessage, on: self)
      .store(in: &cancellables)
  }
}

private extension QuestionsViewModel {
  func updateDateSource(_ questions: [Question]) {
    dataSource = questions
    order = -1
  }

  func nextQuestion() {
    let nextOrder = order + 1
    guard dataSource.count > nextOrder else { return }
    question = dataSource[nextOrder]
    order = nextOrder
  }

  func prevQuestion() {
    let prevOrder = order - 1
    guard prevOrder >= 0 else { return }
    question = dataSource[prevOrder]
    order = prevOrder
  }
}
