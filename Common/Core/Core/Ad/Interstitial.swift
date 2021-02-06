////
////  InterstitialAd.swift
////  Core
////
////  Created by hbkim on 2021/01/30.
////
//
//import SwiftUI
//import UIKit
//import Logging
//import GoogleMobileAds
//
//public final class Interstitial: NSObject, GADInterstitialDelegate {
//  var interstitial: GADInterstitial!
//
//  public override init() {
//    super.init()
//    interstitial = createAndLoadInterstitial()
//  }
//
//  func createAndLoadInterstitial() -> GADInterstitial {
//    let interstitial = GADInterstitial(adUnitID: adUnitID)
//    interstitial.delegate = self
//    interstitial.load(GADRequest())
//    return interstitial
//  }
//
//  public func showAd() {
//    if interstitial.isReady {
//      let root = UIApplication.shared.windows.first?.rootViewController
//      interstitial.present(fromRootViewController: root!)
//    } else {
//      log.info("Ad is not ready")
//    }
//  }
//
//  public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//    interstitial = createAndLoadInterstitial()
//  }
//}
