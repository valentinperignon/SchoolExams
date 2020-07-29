//
//  UINavigationController.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

extension UINavigationController {
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    let backgroundColor = UIColor(red: 239/255, green: 237/255, blue: 255/255, alpha: 1)
    
    let barAppearence = UINavigationBarAppearance()
    barAppearence.backgroundColor = backgroundColor
    barAppearence.shadowColor = backgroundColor
    
    navigationBar.standardAppearance = barAppearence
    navigationBar.scrollEdgeAppearance = barAppearence
    navigationBar.compactAppearance = barAppearence
    
  }
}
