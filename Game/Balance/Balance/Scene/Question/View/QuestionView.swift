//
//  QuestionView.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/26.
//

import SwiftUI
import BalanceService

struct QuestionView: View {
  @ObservedObject var viewModel: QuestionsViewModel
  @Binding var question: Question
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        AnswerButton(title: question.a)

        Text("VS")
          .font(Font.system(size: 24, design: .default))
          .foregroundColor(.purple)
          .padding()

        AnswerButton(title: question.b)
      }
    }
  }

  func AnswerButton(title: String) -> some View {
    Button(action: {
      viewModel.apply(.onNext)
    }, label: {
      Text(title)
        .font(Font.system(size: 18, design: .default))
        .foregroundColor(.white)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }).buttonStyle(GradientButtonStyle())
  }
}

struct GradientButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(Color.white)
      .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
      .cornerRadius(15.0)
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
      .animation(.spring(response: 0.2, blendDuration: 0.2))
  }
}

struct QuestionView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionView(
      viewModel: BalanceModule.questionsViewModel(topicId: 1),
      question: .constant(questions[0])
    ).previewLayout(.fixed(width: 400, height: 600))
  }
}
