//
//  ButtonPrimary.swift
//  MyGrades
//
//  Created by Valentin Perignon on 08/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonFullWidth: View {
  // MARK: Properties
  
  var type: buttonType
  var title: String
  var iconSysName: String?
  var iconName: String?
  var action: () -> Void
  
  // MARK: Body
  
  var body: some View {
    Button(action: action) {
      HStack {
        getIcon()
        Text(title)
      }
      .padding(.vertical)
      .frame(maxWidth: .infinity)
    }
    .background(getColors().bg)
    .foregroundColor(getColors().fg)
    .cornerRadius(10)
    .padding(.horizontal, 15)
  }
  
  // MARK: Function
  
  func getIcon() -> AnyView {
    if let iconSys = iconSysName {
      return AnyView(Image(systemName: iconSys))
    }
    if let icon = iconName {
      return AnyView(Image(icon))
    }
    return AnyView(EmptyView())
  }
  
  func getColors() -> (bg: Color, fg: Color) {
    switch type {
    case .primary:
      return (.mgPurpleLight, .black)
    case .alert:
      return (.red, .white)
    }
  }
  
  // MARK: Enum
  
  enum buttonType {
    case primary, alert
  }
}

struct ButtonFullWidth_Previews: PreviewProvider {
  static var previews: some View {
    ButtonFullWidth(type: .primary, title: "Get Weather", iconName: "cloud", action: {})
  }
}
