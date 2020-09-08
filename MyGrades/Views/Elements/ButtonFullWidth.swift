//
//  ButtonPrimary.swift
//  MyGrades
//
//  Created by Valentin Perignon on 08/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonFullWidth: View {
  // MARK: Environment
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
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
        Text(NSLocalizedString(title, comment: "").uppercased())
          .font(Font.system(.body, design: .rounded))
          .fontWeight(.light)
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
  
  // MARK: Function
  
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
      return (.mgPurpleDark, .mgPurpleLight)
    case .warning:
      return (.orange, .white)
    case .alert:
      return (.red, .white)
    }
  }
  
  // MARK: Enum
  
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
