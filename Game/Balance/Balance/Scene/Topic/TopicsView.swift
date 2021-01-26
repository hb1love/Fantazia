//
//  TopicsView.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/17.
//

import SwiftUI
import Combine
import BalanceService

public struct TopicsView: View {
  
  @ObservedObject var viewModel: TopicsViewModel
  
  public var body: some View {
    VStack {
      TopicList(viewModel: $viewModel.dataSource)
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
