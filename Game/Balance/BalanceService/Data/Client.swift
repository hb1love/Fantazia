//
//  Client.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Foundation
import Combine
import Logging

struct Client {
  func send<T: Decodable>(
    _ request: URLRequest,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) -> AnyPublisher<T, APIError> {
    let requestString = "\(request.httpMethod ?? "") \(request.url?.path ?? "")"
    return URLSession.shared
      .dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw APIError.unknown
        }
        if (httpResponse.statusCode == 401) {
          throw APIError.unauthorized
        }
        if (httpResponse.statusCode == 403) {
          throw APIError.forbidden
        }
        if (httpResponse.statusCode == 404) {
          throw APIError.notFound
        }
        if (400..<500 ~= httpResponse.statusCode) {
          throw APIError.client
        }
        if (500..<600 ~= httpResponse.statusCode) {
          throw APIError.server
        }
        return data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .mapError { error in
        if let error = error as? APIError {
          return error
        }
        if error is URLError {
          return APIError.network
        }
        return APIError.unknown
      }
      .handleEvents(
        receiveSubscription: { _ in
          log.info("REQUEST: \(requestString)")
        },
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            log.info("SUCCESS: \(requestString)")
          case .failure(let error):
            log.warning("FAILURE: \(requestString) - \(error.localizedDescription)")
          }
        }
      )
      .eraseToAnyPublisher()
  }
}
