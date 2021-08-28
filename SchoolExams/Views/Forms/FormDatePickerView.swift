//
//  FormDatePickerView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 09/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormDatePickerView: View {
  // MARK:: Property
  
  var title: String
  
  @Binding var selectedDate: Date
  
  // MARK: Body
  
  var body: some View {
    VStack {
      FormSectionTitle(title: title)
      
      DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
        .labelsHidden()
    }
    .padding(.horizontal, 15)
  }
}

struct FormDatePickerView_Previews: PreviewProvider {
  static var previews: some View {
    FormDatePickerView(title: "Date", selectedDate: .constant(Date()))
  }
}
