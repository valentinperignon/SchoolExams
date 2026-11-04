//
//  AppStoreReviewManager.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 28/09/2021.
//  Copyright © 2021 Valentin Perignon. All rights reserved.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    private static let worthActionNumber = 3

    private static let keyActionNumber = "APRM_ActionNumber"
    private static let keyLastVersion = "APRM_LastVersion"

    @MainActor
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

    @MainActor
    private static func request() {
        guard let scene = UIApplication.shared.currentScene else { return }
        AppStore.requestReview(in: scene)
    }
}
