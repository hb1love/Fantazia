//
//  Topic.swift
//  BalanceService
//
//  Created by hbkim on 2021/01/17.
//

import Foundation
import SwiftUI

public struct Topic: Hashable, Codable, Identifiable {
  public var id: Int
  
  var type: TopicType
  public var title: String {
    type.name
  }
  
  var imageURL: String
  public var image: Image {
    Image(imageURL)
  }
  
  public static var `default` = Topic(id: 1, type: .love, imageURL: "bg_love")
}

public enum TopicType: String, CaseIterable, Codable {
  case love
  case life
  
  var name: String {
    switch self {
    case .love:
      return "연애관"
    case .life:
      return "가치관"
    }
  }
}
