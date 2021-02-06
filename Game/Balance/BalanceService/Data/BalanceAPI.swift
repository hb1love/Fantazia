//
//  BalanceAPI.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Combine

public var topics: [Topic] = load("topicsData.json")
public var questions: [Question] = {
  let topics: [Topic] = load("topicsData.json")
  return topics.first!.questions
}()

enum BalanceAPI {
  private static var baseURL: URL {
    URL(string: BalanceServiceModule.baseUrl)!
  }
  private static let client = Client()
  
  static func topics() -> AnyPublisher<[Topic], APIError> {
    let url = baseURL.appendingPathComponent("topics")
    let request = URLComponents(url: url, resolvingAgainstBaseURL: true)?.request
    return client.send(request!)
  }
  
  static func topic(id: Int64) -> AnyPublisher<Topic, APIError> {
    let url = baseURL.appendingPathComponent("topics/\(id)")
    let request = URLComponents(url: url, resolvingAgainstBaseURL: true)?.request
    return client.send(request!)
  }
}

private extension URLComponents {
  var request: URLRequest? {
    url.map { URLRequest.init(url: $0) }
  }
}

func load<T: Decodable>(_ filename: String) -> T {
  let data: Data
  
  guard let file = Bundle(identifier: "com.seasons.fantazia.balanceservice")?.url(forResource: filename, withExtension: nil)
  else {
    fatalError("Couldn't find \(filename) in main bundle.")
  }
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
  }
}
