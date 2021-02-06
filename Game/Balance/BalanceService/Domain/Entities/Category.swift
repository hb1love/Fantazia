//
//  Category.swift
//  BalanceService
//
//  Created by hbkim on 2021/02/02.
//

import SwiftUI

public enum Category: String, CaseIterable, Codable {
  case general
  case lover
  case life
  case ethics
  case adult
  case food

  var image: Image {
    switch self {
    case .general: return "bg_general".image
    case .lover: return "bg_lover".image
    case .life: return "bg_life".image
    case .ethics: return "bg_ethics".image
    case .adult: return "bg_adult".image
    case .food: return "bg_food".image
    }
  }
}
