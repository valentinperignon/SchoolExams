//
//  FormSectionTitle.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormSectionTitle: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var title: String
  
  var body: some View {
      HStack {
        Text(NSLocalizedString(title, comment: "").uppercased())
          .font(.caption)
          .fontWeight(.bold)
          .foregroundStyle(colorScheme == .light ? Color.mgPurpleDark : .mgPurpleLight_dark)
        Spacer()
      }
  }
}

#Preview {
  FormSectionTitle(title: "My title")
}
