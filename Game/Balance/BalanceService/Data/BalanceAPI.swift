//
//  BalanceAPI.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Combine

public var topics: [Topic] = load("topicData.json")
public var questions: [Question] = load("questionData.json")

enum BalanceAPI {
  private static let base = URL(string: "http://")!
  private static let client = Client()
  
  static func topics() -> AnyPublisher<[Topic], Error> {
    let topics: [Topic] = load("topicData.json")
    return Just(topics)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
//    let request = URLComponents(url: base.appendingPathComponent("topics"), resolvingAgainstBaseURL: true)?.request
//    return client.send(request!)
  }
  
  static func questions() -> AnyPublisher<[Question], Error> {
    let questions: [Question] = load("questionData.json")
    return Just(questions)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
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
