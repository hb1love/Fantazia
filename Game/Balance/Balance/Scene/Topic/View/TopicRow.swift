//
//  TopicRow.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/17.
//

import SwiftUI
import BalanceService

struct TopicRow: View {
  var topic: Topic
  
  var body: some View {
    ZStack {
      topic.image
        .resizable()
        .cornerRadius(12)
        .shadow(color: .gray, radius: 10)

      Text(topic.title)
        .font(Font.system(size: 24, design: .default))
        .foregroundColor(Color.white)
    }
    .padding(.vertical, 16)
    .listRowBackground(Color.white)
  }
}

struct TopicRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TopicRow(topic: topics[0])
      TopicRow(topic: topics[1])
    }.previewLayout(.fixed(width: 400, height: 300))
  }
}
