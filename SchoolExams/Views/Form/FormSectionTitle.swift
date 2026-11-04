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
        Text(title.uppercased())
          .font(.caption)
          .fontWeight(.bold)
          .foregroundColor(.mgPurpleDark)
        Spacer()
      }
  }
}

#Preview {
  FormSectionTitle(title: "My title")
}
