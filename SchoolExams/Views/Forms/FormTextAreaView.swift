//
//  FormTextAreaView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormTextFieldView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var keyboardType: UIKeyboardType
  
  var title: String
  @Binding var textValue: String
  
  var body: some View {
    VStack {
      // ----- Title
      FormSectionTitle(title: title)
      
      // ----- Field
      TextField("Write something here", text: $textValue)
        .keyboardType(keyboardType)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(colorScheme == .light ? Color.appleGray : Color.appleDarkGray5)
        .clipShape(.rect(cornerRadius: 8))
    }
    .padding(.horizontal, 15)
  }
}

#Preview {
  FormTextFieldView(keyboardType: .default, title: "My Title", textValue: .constant(""))
}
