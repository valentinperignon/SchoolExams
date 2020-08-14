//
//  FormButtonView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormButtonView: View {
  // MARK: Property
  
  var label: String
  var action: () -> Void
  
  // MARK: Body
  
  var body: some View {
    Button(action: action) {
      HStack {
        Spacer()
        Text(label)
        Spacer()
      }
    }
    .accentColor(.primary)
    .padding(.vertical, 15)
    .background(Color.mgPurpleLight)
    .cornerRadius(10)
    .padding(.horizontal,15)
  }
}

struct FormButtonView_Previews: PreviewProvider {
  static var previews: some View {
    FormButtonView(label: "Button Text") {}
  }
}
