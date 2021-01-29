//
//  QuestionView.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/26.
//

import SwiftUI
import BalanceService
import Resource

struct QuestionView: View {
  @ObservedObject var viewModel: QuestionsViewModel
  @Binding var question: Question
  
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 16) {
        Text(question.q ?? "")
          .foregroundColor(Color.black)
          .font(Font.system(size: 18, weight: .bold, design: .rounded))
        AnswerButton(title: question.a, color: Color.questionA)
        AnswerButton(title: question.b, color: Color.questionB)
      }
    }
  }

  func AnswerButton(title: String, color: Color) -> some View {
    Button(action: {
      viewModel.apply(.onNext)
    }, label: {
      Text(title)
        .font(Font.system(size: 24, weight: .bold, design: .rounded))
        .multilineTextAlignment(.center)
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(color)
        .cornerRadius(15.0)
    }).buttonStyle(GradientButtonStyle())
  }
}

struct GradientButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
      .animation(.spring(response: 0.2, blendDuration: 0.2))
  }
}

struct QuestionView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionView(
      viewModel: BalanceModule.questionsViewModel(topic: Topic.default),
      question: .constant(questions[0])
    ).previewLayout(.fixed(width: 400, height: 600))
  }
}
