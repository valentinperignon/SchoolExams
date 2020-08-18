//
//  FormSegmentedPickerView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormSegmentedPickerView: View {
  // MARK:: Property
  
  var title: String
  
  @Binding var value: Subject.CustomColor
  
  // MARK: Body
  
  var body: some View {
    VStack {
      FormSectionTitle(title: title)
      
      Picker("", selection: $value) {
        ForEach(Subject.CustomColor.allCases, id: \.self) { element in
          Text(NSLocalizedString(element.rawValue, comment: ""))
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
    .padding(.horizontal, 15)
  }
}

struct FormSegmentedPickerView_Previews: PreviewProvider {
  static var previews: some View {
    FormSegmentedPickerView(title: "My title", value: .constant(.purple))
  }
}
