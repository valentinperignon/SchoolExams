//
//  FormTextAreaView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormTextFieldView: View {
  // MARK: Property
  
  var title: String
  @Binding var textValue: String
  
  // MARK: Body
  
  var body: some View {
    VStack {
      // ----- Title
      FormSectionTitle(title: title)
      
      // ----- Field
      TextField("Type something here", text: $textValue)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.appleGray)
        .cornerRadius(8)
    }
    .padding(.horizontal, 15)
  }
}

struct FormTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    FormTextFieldView(title: "My Title", textValue: .constant(""))
  }
}
