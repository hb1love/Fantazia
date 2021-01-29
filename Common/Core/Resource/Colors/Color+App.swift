//
//  Color+App.swift
//  Resource
//
//  Created by hbkim on 2021/01/29.
//

import SwiftUI

public extension Color {
  static let primary = Color(r: 255, g: 88, b: 88)

  static let questionA = Color(r: 250, g: 88, b: 88)
  static let questionB = Color(r: 88, g: 88, b: 250)
}

public extension Color {
  init(r: Int, g: Int, b: Int, opacity: Double = 1.0) {
    let red: Double = Double(r) / 255
    let green: Double = Double(g) / 255
    let blue: Double = Double(b) / 255
    self.init(red: red, green: green, blue: blue, opacity: opacity)
  }

  init(hex: Int, opacity: Double = 1.0) {
    self.init(
      red: Double((hex >> 16) & 0xff) / 255.0,
      green: Double((hex >> 8) & 0xff) / 255.0,
      blue: Double(hex & 0xff) / 255.0,
      opacity: opacity
    )
  }
}
