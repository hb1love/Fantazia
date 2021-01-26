//
//  BalanceError.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Foundation

public enum APIError: Error, LocalizedError {
  case unknown
  case apiError(reason: String)
  case parseError(reason: String)
  case networkError(from: URLError)
}

public enum BalanceError: Error {
  case request(reason: APIError)
  case noTopic
  case notMatchTopic
  case noQuestion
}
