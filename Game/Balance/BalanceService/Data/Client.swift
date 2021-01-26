//
//  Client.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Foundation
import Combine

struct Client {
  func send<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, APIError> {
    return URLSession.shared
      .dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw APIError.unknown
        }
        if (httpResponse.statusCode == 401) {
          throw APIError.apiError(reason: "Unauthorized");
        }
        if (httpResponse.statusCode == 403) {
          throw APIError.apiError(reason: "Resource forbidden");
        }
        if (httpResponse.statusCode == 404) {
          throw APIError.apiError(reason: "Resource not found");
        }
        if (405..<500 ~= httpResponse.statusCode) {
          throw APIError.apiError(reason: "client error");
        }
        if (500..<600 ~= httpResponse.statusCode) {
          throw APIError.apiError(reason: "server error");
        }
        return data
      }
      .handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .mapError { error in
        if let error = error as? APIError {
          return error
        }
        if let urlError = error as? URLError {
          return APIError.networkError(from: urlError)
        }
        return APIError.unknown
      }
      .eraseToAnyPublisher()
  }
}
