//
//  ButtonPrimaryView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 02/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonPrimaryView: View {
  // MARK: Properties
  
  var iconName: String?
  var label: String
  var action: () -> Void
  
  // MARK: Body
  
  var body: some View {
    Button(action: action) {
      HStack {
        if let icon = iconName {
          Image(systemName: icon)
            .foregroundColor(.black)
        }
        Text(label)
          .foregroundColor(.black)
      }
      .frame(maxWidth: .infinity)
      .padding()
    }
    .background(Color.mgPurpleLight)
    .cornerRadius(10)
    .padding(.horizontal, 15)
  }
}

struct ButtonPrimaryView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonPrimaryView(iconName: "plus", label: "New Grade", action: {})
  }
}
