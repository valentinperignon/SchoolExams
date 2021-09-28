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
    static let maxRequestNumber = 3
    
    static let defaultsKey = "RequestNumber"
    
    static func requestReviewIfPossible() {
        let defaults = UserDefaults.standard
        
        var requestNumber = defaults.integer(forKey: defaultsKey)
        guard requestNumber < maxRequestNumber else { return }
        
        requestNumber += 1
        defaults.set(requestNumber, forKey: defaultsKey)
        
        request()
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
