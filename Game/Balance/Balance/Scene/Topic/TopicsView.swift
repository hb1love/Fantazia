//
//  TopicsView.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/17.
//

import SwiftUI
import Combine
import BalanceService
import Logging
import Resource

public struct TopicsView: View {
  
  @ObservedObject var viewModel: TopicsViewModel
  
  public var body: some View {
    NavigationView {
      TopicList(viewModel: $viewModel.dataSource)
        .navigationTitle("토픽")
        .padding(.bottom, 32)
        .edgesIgnoringSafeArea(.bottom)
    }
    .onAppear(perform: { viewModel.apply(.onAppear) })
    .edgesIgnoringSafeArea(.top)
    .edgesIgnoringSafeArea(.bottom)
  }
}

struct TopicsView_Previews: PreviewProvider {
  static var previews: some View {
    BalanceModule.topicView()
  }
}
