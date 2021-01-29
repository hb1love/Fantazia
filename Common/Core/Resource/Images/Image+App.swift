//
//  Image+App.swift
//  Resource
//
//  Created by hbkim on 2021/01/29.
//

import SwiftUI

public extension String {
  var image: Image {
    return Image(self, bundle: Bundle(identifier: "com.seasons.fantazia.resource"))
  }
}
