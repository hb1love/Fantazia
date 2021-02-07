//
//  UIFont+App.swift
//  Resource
//
//  Created by hbkim on 2021/02/04.
//

import Logging
import SwiftUI

public enum AppFont: String {
  case nanumBarunpenB = "NanumBarunpen-Bold"
  case nanumBarunpenR = "NanumBarunpen"
}

public extension Font {
  static func preferredFont(type: AppFont, size: CGFloat) -> Font {
    return Font.custom(type.rawValue, size: size)
  }
}

public extension Font {
  static func loadAllFonts(identifier: String = "com.seasons.fantazia.resource") {
    registerFont(filename: "NanumBarunpenB.otf", identifier: identifier)
    registerFont(filename: "NanumBarunpenR.otf", identifier: identifier)
  }

  static func registerFont(filename: String, identifier: String) {
    if let frameworkBundle = Bundle(identifier: identifier) {
      let filePath = frameworkBundle.path(forResource: filename, ofType: nil)!
      let fontData = NSData(contentsOfFile: filePath)!
      let dataProvider = CGDataProvider(data: fontData)!
      let fontRef = CGFont(dataProvider)!
      var errorRef: Unmanaged<CFError>? = nil

      if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
        log.debug("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
      }
    }
    else {
      log.warning("Failed to register font - bundle identifier invalid.")
    }
  }
}

public extension UIFont {
  static func preferredFont(type: AppFont, size: CGFloat) -> UIFont {
    return UIFont(name: type.rawValue, size: size)!
  }
}

public extension UIFont {
  static func loadAllFonts(identifier: String = "com.seasons.fantazia.resource") {
    registerFont(filename: "NanumBarunpenB.otf", identifier: identifier)
    registerFont(filename: "NanumBarunpenR.otf", identifier: identifier)
  }

  static func registerFont(filename: String, identifier: String) {
    if let frameworkBundle = Bundle(identifier: identifier) {
      let filePath = frameworkBundle.path(forResource: filename, ofType: nil)!
      let fontData = NSData(contentsOfFile: filePath)!
      let dataProvider = CGDataProvider(data: fontData)!
      let fontRef = CGFont(dataProvider)!
      var errorRef: Unmanaged<CFError>? = nil

      if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
        log.debug("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
      }
    }
    else {
      log.warning("Failed to register font - bundle identifier invalid.")
    }
  }
}
