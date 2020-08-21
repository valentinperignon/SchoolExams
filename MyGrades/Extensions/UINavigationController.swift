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
    
    let backgroundColor = UIColor(red: 227/255, green: 222/255, blue: 255/255, alpha: 1)
    let textColor = UIColor(red: 73/255, green: 34/255, blue: 211/255, alpha: 1)
    
    let barAppearence = UINavigationBarAppearance()
    barAppearence.backgroundColor = backgroundColor
    barAppearence.shadowColor = backgroundColor
    barAppearence.largeTitleTextAttributes = [.foregroundColor: textColor]
    barAppearence.titleTextAttributes = [.foregroundColor: textColor]
    
    navigationBar.standardAppearance = barAppearence
    navigationBar.scrollEdgeAppearance = barAppearence
    navigationBar.compactAppearance = barAppearence
    
    navigationBar.tintColor = UIColor.black
  }
}
