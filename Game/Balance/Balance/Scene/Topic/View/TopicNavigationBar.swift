//
//  TopicNavigationBar.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/24.
//

import SwiftUI

struct TopicNavigationBar: View {
  var body: some View {
    HStack {
      Text("Topic")
        .foregroundColor(Color.white.opacity(0.9))
        .font(Font.system(size: 24, design: .default))
        .bold()
      
      Spacer()
    }
  }
}

struct TopicNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    TopicNavigationBar()
  }
}
