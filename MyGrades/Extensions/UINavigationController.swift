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
    
    // Colors
    let lightPurpleColor = UIColor(red: 227/255, green: 222/255, blue: 255/255, alpha: 1)
    let darkPurpleColor = UIColor(red: 73/255, green: 34/255, blue: 211/255, alpha: 1)
    
    let darkModePurpleColor = UIColor(red: 59/255, green: 24/255, blue: 184/255, alpha: 1)
    
    // BarAppearence
    let barAppearence = UINavigationBarAppearance()
    
    // Colors for light and dark themes
    if traitCollection.userInterfaceStyle == .light {
      barAppearence.backgroundColor = lightPurpleColor
      barAppearence.shadowColor = lightPurpleColor
      barAppearence.largeTitleTextAttributes = [.foregroundColor: darkPurpleColor]
      barAppearence.titleTextAttributes = [.foregroundColor: darkPurpleColor]
      
      navigationBar.tintColor = darkPurpleColor
    } else {
      barAppearence.backgroundColor = darkModePurpleColor
      barAppearence.shadowColor = darkModePurpleColor
      barAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      barAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
      
      navigationBar.tintColor = UIColor.white
    }
    
    // NavigationBar appearence
    navigationBar.standardAppearance = barAppearence
    navigationBar.scrollEdgeAppearance = barAppearence
    navigationBar.compactAppearance = barAppearence
  }
}
