//
//  ButtonCircle.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 22/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ButtonCircle: View {
  // MARK: Property
  
  var action: () -> Void
  
  // MARK: Body
  
  var body: some View {
    Button(action: action) {
      Image(systemName: "plus")
        .font(.title)
    }
    .padding()
    .background(Color.mgPurpleDark)
    .foregroundColor(.mgPurpleLight)
    .clipShape(Circle())
    .shadow(radius: 10)
    .padding(.trailing, 22)
    .padding(.bottom, 20)
  }
}

struct ButtonCircle_Previews: PreviewProvider {
  static var previews: some View {
    ButtonCircle(action: {})
  }
}
