//
//  ButtonListStyle.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 24/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonListStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(configuration.isPressed ? Color.appleGray : Color.white)
      .cornerRadius(configuration.isPressed ? 10 : 0)
  }
}
