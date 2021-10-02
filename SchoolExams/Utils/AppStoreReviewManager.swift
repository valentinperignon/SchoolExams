//
//  AppStoreReviewManager.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 28/09/2021.
//  Copyright © 2021 Valentin Perignon. All rights reserved.
//

import StoreKit
import Foundation

struct AppStoreReviewManager {
  private static let worthActionNumber = 3
  
  private static let keyActionNumber = "APRM_ActionNumber"
  private static let keyLastVersion = "APRM_LastVersion"
  
  static func requestReviewIfPossible() {
    let defaults = UserDefaults.standard
    
    let existsInUD = defaults.object(forKey: keyActionNumber) != nil
    
    var actionNumber = defaults.integer(forKey: keyActionNumber)
    actionNumber += 1
    
    guard actionNumber >= worthActionNumber || !existsInUD else { return }
    
    let bundleversionKey = kCFBundleVersionKey as String
    let currentVersion = Bundle.main.object(forInfoDictionaryKey: bundleversionKey) as? String
    
    let lastVersion = defaults.string(forKey: keyLastVersion)
    
    guard lastVersion == nil || lastVersion != currentVersion else { return }
    
    request()
    defaults.set(0, forKey: keyActionNumber)
    defaults.set(currentVersion, forKey: keyLastVersion)
  }
  
  private static func request() {
    if #available(iOS 14.0, *) {
      guard let scnene = UIApplication.shared.currentScene else { return }
      SKStoreReviewController.requestReview(in: scnene)
    } else {
      SKStoreReviewController.requestReview()
    }
  }
}
