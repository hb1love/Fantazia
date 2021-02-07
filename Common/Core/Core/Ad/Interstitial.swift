//
//  InterstitialAd.swift
//  Core
//
//  Created by hbkim on 2021/01/30.
//

import SwiftUI
import UIKit
import Logging
import GoogleMobileAds

public final class Interstitial: NSObject, GADInterstitialDelegate {
  var adUnitId: String
  var interstitial: GADInterstitial!

  var endAction: (() -> Void)?

  public init(adUnitId: String) {
    self.adUnitId = adUnitId
    super.init()

    interstitial = createAndLoadInterstitial()
  }

  func createAndLoadInterstitial() -> GADInterstitial {
    let interstitial = GADInterstitial(adUnitID: adUnitId)
    interstitial.delegate = self
    interstitial.load(GADRequest())
    return interstitial
  }

  public func showAd(action: @escaping () -> Void) {
    if interstitial.isReady {
      self.endAction = action
      let root = UIApplication.shared.windows.first?.rootViewController
      interstitial.present(fromRootViewController: root!)
    } else {
      log.info("Ad is not ready")
    }
  }

  public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
    interstitial = createAndLoadInterstitial()
    endAction?()
  }
}
