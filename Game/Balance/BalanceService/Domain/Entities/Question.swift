//
//  Question.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/26.
//

import Foundation
import SwiftUI

public struct Question: Hashable, Codable, Identifiable {
  public var id: Int
  var topicIds: [Int]

  public var q: String?
  public var a: String
  public var b: String
  
  public static var `default` = Question(id: -1, topicIds: [1, 2], q: nil, a: "", b: "")
}
