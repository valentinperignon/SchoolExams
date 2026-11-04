//
//  FormStepperView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormStepperView: View {
  // Properties
  
  var title: String
  
  @Binding var value: Double
  
  var incrementAction: () -> Void
  var decrementAction: () -> Void
  
  // MARK: Body
  var body: some View {
    VStack {
      FormSectionTitle(title: title)
      
      Stepper(
        onIncrement: incrementAction,
        onDecrement: decrementAction
      ) {
          Text("\(self.value.description)")
      }
    }
    .padding(.horizontal, 15)
  }
}

#Preview {
  FormStepperView(title: "My title", value: .constant(5), incrementAction: {}, decrementAction: {})
}
