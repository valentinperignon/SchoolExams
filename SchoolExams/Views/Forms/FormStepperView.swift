//
//  FormStepperView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormStepperView: View {
  var title: String
  
  @Binding var value: Double
  
  var range: ClosedRange<Double>
  var step: Double
  
  var body: some View {
    VStack {
      FormSectionTitle(title: title)
      
      Stepper(self.value.description, value: $value, in: range, step: step, onEditingChanged: {_ in})
    }
    .padding(.horizontal, 15)
  }
}

#Preview {
  FormStepperView(title: "My title", value: .constant(5), range: 0...20, step: 0.5)
}
