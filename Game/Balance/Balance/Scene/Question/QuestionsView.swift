//
//  QuestionsView.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/25.
//

import SwiftUI
import BalanceService

public struct QuestionsView: View {
  
  @ObservedObject var viewModel: QuestionsViewModel
  
  public var body: some View {
    NavigationView {
      VStack {
        QuestionView(viewModel: viewModel, question: $viewModel.question)
        HStack {
          Button(action: {
            viewModel.apply(.onPrev)
          }, label: {
            Text("이전 질문")
              .font(Font.system(size: 18, design: .default))
              .foregroundColor(.black)
              .padding(.vertical, 16)
          })
          Spacer()
        }.padding(.all, 16)
      }
      .padding(.all, 16)
      .onAppear(perform: { viewModel.apply(.onAppear) })
    }
    .edgesIgnoringSafeArea(.top)
    .edgesIgnoringSafeArea(.bottom)
  }
}

struct QuestionsView_Previews: PreviewProvider {
  static var previews: some View {
    BalanceModule.questionsView(topicId: topics[0].id)
  }
}
