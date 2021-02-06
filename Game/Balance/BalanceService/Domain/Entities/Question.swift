//
//  Question.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/26.
//

import SwiftUI

public struct Question: Hashable, Codable, Identifiable {
  public var id: Int64
  public var q: String?
  public var a: String
  public var b: String
  
  public static var `default` = Question(id: -1, q: nil, a: "", b: "")
}
