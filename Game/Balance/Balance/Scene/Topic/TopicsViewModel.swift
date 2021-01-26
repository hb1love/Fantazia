//
//  TopicsViewModel.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/17.
//

import Combine
import BalanceService
import Logging

final class TopicsViewModel: ObservableObject, Identifiable {
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Input
  enum Input {
    case onAppear
  }
  
  func apply(_ input: Input) {
    switch input {
    case .onAppear: onAppearSubject.send(())
    }
  }
  private let onAppearSubject = PassthroughSubject<Void, Never>()
  
  // MARK: - Output
  @Published var dataSource: TopicListModel = .init()
  @Published var errorMessage = ""
  
  private let responseSubject = PassthroughSubject<[Topic], Never>()
  private let errorSubject = PassthroughSubject<BalanceError, Never>()
  private let trackingSubject = PassthroughSubject<LogEvent, Never>()
  
  private let balanceService: BalanceService
  private let loggingService: LoggingService
  init(
    balanceService: BalanceService,
    loggingService: LoggingService
  ) {
    self.balanceService = balanceService
    self.loggingService = loggingService
    
    bindInputs()
    bindOutputs()
  }
  
  private func bindInputs() {
    let responsePublisher = onAppearSubject
      .flatMap { [balanceService] _ in
        balanceService.getTopics()
          .catch { [weak self] error -> Empty<[Topic], Never> in
            self?.errorSubject.send(error)
            return .init()
          }
      }
    
    responsePublisher
      .share()
      .subscribe(responseSubject)
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
      .map(TopicListModel.init)
      .assign(to: \.dataSource, on: self)
      .store(in: &cancellables)
    
    errorSubject
      .map { error -> String in
        switch error {
        case .request: return "요청 에러"
        case .noTopic: return "no topics"
        default: return ""
        }
      }
      .assign(to: \.errorMessage, on: self)
      .store(in: &cancellables)
  }
}


