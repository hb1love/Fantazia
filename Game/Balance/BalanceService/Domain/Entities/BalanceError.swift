//
//  BalanceError.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

public enum APIError: Error, LocalizedError {
  case unknown
  case unauthorized
  case forbidden
  case notFound
  case client
  case server
  case network
  case parse

  public var errorDescription: String? {
    switch self {
    case .unknown: return "unknown error"
    case .unauthorized: return "unauthorized error"
    case .forbidden: return "forbidden error"
    case .notFound: return "notFound error"
    case .client: return "client error"
    case .server: return "server error"
    case .network: return "network error"
    case .parse: return "parse error"
    }
  }
}

public enum BalanceError: Error {
  case request(reason: APIError)
  case noTopic
  case notMatchTopic
  case noQuestion
}
