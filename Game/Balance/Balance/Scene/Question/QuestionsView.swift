//
//  QuestionsView.swift
//  BalanceUI
//
//  Created by hbkim on 2021/01/25.
//

import SwiftUI
import BalanceService
import Resource
import Core
import Logging
import GoogleMobileAds

public struct QuestionsView: View {
  @Environment(\.presentationMode) var presentationMode

  var interstitial: Interstitial

  @ObservedObject var viewModel: QuestionsViewModel

  init(viewModel: QuestionsViewModel) {
    self.viewModel = viewModel
    self.interstitial = Interstitial(adUnitId: viewModel.adUnitId)
  }
  
  public var body: some View {
    ZStack {
      VStack {
        QuestionView(viewModel: viewModel, question: $viewModel.question)
          .padding(.all, 32)
          .onAppear(perform: { viewModel.apply(.onAppear) })

        Spacer()
      }.padding(.bottom, 64)

      VStack(alignment: .center) {
        Spacer()
        HStack(spacing: 20) {
          Button(action: {
            viewModel.apply(.onPrev)
          }, label: {
            "ic_prev".image
          })
          Button(action: {
            viewModel.apply(.onNext)
          }, label: {
            "ic_next".image
          })
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(28)
        .shadow(radius: 10)
        .padding(.bottom, 8)
      }
    }
    .alert(isPresented: $viewModel.showAlert,
           TextAlert(title: "마지막 문항입니다 👻",
                     action: { _ in
                      interstitial.showAd {
                        self.presentationMode.wrappedValue.dismiss()
                      }}))
    .navigationTitle(viewModel.title)
  }
}

struct QuestionsView_Previews: PreviewProvider {
  static var previews: some View {
    BalanceModule.questionsView(topic: topics[0])
  }
}
