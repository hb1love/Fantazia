//
//  TopicList.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/24.
//

import SwiftUI
import BalanceService
import Logging

struct TopicList: View {
  @Binding var viewModel: TopicListModel {
    didSet {
      log.debug(viewModel)
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(showsIndicators: false) {
        LazyVStack {
          ForEach(viewModel.topics, id: \.self) { topic in
            NavigationLink(destination: BalanceModule.questionsView(topic: topic)) {
              TopicRow(topic: topic)
                .id(topic.id)
                .frame(minWidth: 0,
                       idealWidth: geometry.size.width,
                       maxWidth: geometry.size.width)
                .frame(height: geometry.size.width / 3 * 2)
            }
          }
          .padding(.horizontal, 32)
        }
        .padding(.vertical, 32)
      }
    }
  }
}

struct TopicList_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(["iPhone 8", "iPhone 12 Pro"], id: \.self) { deviceName in
      TopicList(viewModel: .constant(TopicListModel(topics: topics)))
        .previewDevice(PreviewDevice(rawValue: deviceName))
        .previewDisplayName(deviceName)
    }
  }
}
