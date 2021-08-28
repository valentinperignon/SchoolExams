//
//  ButtonPrimary.swift
//  MyGrades
//
//  Created by Valentin Perignon on 08/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonFullWidth: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var type: buttonType
  var title: String
  var iconSysName: String?
  var iconName: String?
  var action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack {
        getIcon()
        Text(NSLocalizedString(title, comment: "").capitalized)
          .font(Font.system(.body, design: .rounded))
          .fontWeight(colorScheme == .light ? .light : .medium)
        .lineLimit(nil)
      }
      .padding(.vertical, 15)
      .frame(maxWidth: .infinity)
      .background(getColors(colorScheme: colorScheme).bg)
      .foregroundColor(getColors(colorScheme: colorScheme).fg)
      .cornerRadius(10)
    }
    .buttonStyle(ButtonFullWidthStyle())
    .padding(.horizontal, 15)
  }
  
  func getIcon() -> AnyView {
    if let iconSys = iconSysName {
      return AnyView(Image(systemName: iconSys))
    }
    if let icon = iconName {
      return AnyView(
        Image(icon)
          .resizable()
          .frame(width: 22, height: 22)
      )
    }
    return AnyView(EmptyView())
  }
  
  func getColors(colorScheme: ColorScheme) -> (bg: Color, fg: Color) {
    if colorScheme == .light {
      switch type {
      case .primary:
        return (.mgPurpleLight, .mgPurpleDark)
      case .warning:
        return (.mgOrangeLight, .mgOrangeDark)
      case .alert:
        return (.red, .white)
      }
    }
    
    switch type {
    case .primary:
      return (.mgPurpleDark, .white)
    case .warning:
      return (.orange, .white)
    case .alert:
      return (.red, .white)
    }
  }
  
  enum buttonType {
    case primary, warning, alert
  }
}

struct ButtonFullWidth_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ButtonFullWidth(type: .primary, title: "Get Weather", iconSysName: "cloud.sun", action: {})
      ButtonFullWidth(type: .warning, title: "Cancel", iconSysName: "arrow.left", action: {})
      ButtonFullWidth(type: .alert, title: "Remove", iconSysName: "bin", action: {})
    }
  }
}
