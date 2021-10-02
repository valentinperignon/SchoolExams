//
//  UIApplication+CurrentScene.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 28/09/2021.
//  Copyright © 2021 Valentin Perignon. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
  var currentScene: UIWindowScene? {
    connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
  }
}
