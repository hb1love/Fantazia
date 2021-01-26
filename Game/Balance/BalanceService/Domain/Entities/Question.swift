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
  var types: [TopicType]
  
  public var a: String
  public var b: String
  
  public static var `default` = Question(id: -1, types: TopicType.allCases, a: "", b: "")
}
