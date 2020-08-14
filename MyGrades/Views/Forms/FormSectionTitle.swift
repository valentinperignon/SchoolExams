//
//  FormSectionTitle.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormSectionTitle: View {
  // MARK: Property
  
  var title: String
  
  // MARK: Body
  
  var body: some View {
      HStack {
        Text(NSLocalizedString(title, comment: "").uppercased())
          .font(.caption)
          .fontWeight(.bold)
          .foregroundColor(.mgPurpleDark)
        Spacer()
      }
  }
}

struct FormSectionTitle_Previews: PreviewProvider {
  static var previews: some View {
    FormSectionTitle(title: "My title")
  }
}
