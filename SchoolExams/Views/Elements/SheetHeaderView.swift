//
//  SheetHeaderView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 10/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct SheetHeaderView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var title: String
  var subtitle: String
  
  var body: some View {
    VStack {
      HStack {
        Text(NSLocalizedString(title, comment: ""))
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundStyle(colorScheme == .light ? Color.mgPurpleDark : .white)
        Spacer()
      }
      HStack {
        Text(NSLocalizedString(subtitle, comment: ""))
          .font(.callout)
          .foregroundStyle(colorScheme == .light ? Color.mgPurpleDark : .white)
        Spacer()
      }
    }
    .accessibilityElement(children: .combine)
    .accessibilityAddTraits(.isHeader)
    .padding([.horizontal, .bottom])
    .padding(.top, 60)
    .background(colorScheme == .light ? Color.mgPurpleLight : Color.mgPurpleDark_dark)
    .padding(.bottom, 22)
  }
}

#Preview {
  SheetHeaderView(title: "My Title", subtitle: "My subtitle")
}
