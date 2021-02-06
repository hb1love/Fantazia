//
//  Topic.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Foundation
import SwiftUI
import Resource

public struct Topic: Hashable, Codable, Identifiable {
  public var id: Int64
  public var title: String

  var category: Category
  public var image: Image {
    category.image
  }

  public var questions: [Question] = []
  
  public static var `default` = Topic(
    id: 1,
    title: "일반",
    category: .adult,
    questions: []
  )
}
