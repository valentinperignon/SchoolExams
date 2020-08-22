//
//  ButtonCircleStyle.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 22/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct MGButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.9 : 1)
  }
}
