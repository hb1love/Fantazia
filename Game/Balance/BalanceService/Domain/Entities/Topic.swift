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
  public var id: Int
  
  var type: TopicType
  public var title: String {
    type.name
  }
  
  var imageURL: String
  public var image: Image {
    imageURL.image
  }
  
  public static var `default` = Topic(id: 1, type: .all, imageURL: "bg_lover")
}

public enum TopicType: String, CaseIterable, Codable {
  case lover
  case life
  case food
  case ethics
  case adult
  case general
  case all
  
  var name: String {
    switch self {
    case .lover:
      return "연애관"
    case .life:
      return "인생"
    case .ethics:
      return "윤리관"
    case .food:
      return "음식"
    case .adult:
      return "19"
    case .general:
      return "일반"
    case .all:
      return "전체"
    }
  }
}
