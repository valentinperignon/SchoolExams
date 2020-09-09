//
//  ButtonCircle.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 22/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonCircle: View {
  // MARK; Environment
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  // MARK: Property
  
  var action: () -> Void
  
  // MARK: Body
  
  var body: some View {
    Button(action: action) {
      Image(systemName: "plus")
        .font(.title)
        .padding()
        .background(colorScheme == .light ? Color.mgPurpleDark : Color.mgPurpleLight_dark)
        .foregroundColor(colorScheme == .light ? Color.mgPurpleLight : Color.mgPurpleDark_dark)
        .clipShape(Circle())
        .shadow(radius: 10)
    }
    .buttonStyle(ButtonCircleStyle())
    .padding(.trailing, 22)
    .padding(.bottom, 20)
  }
}

struct ButtonCircle_Previews: PreviewProvider {
  static var previews: some View {
    ButtonCircle(action: {})
  }
}
