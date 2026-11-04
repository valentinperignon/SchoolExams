//
//  FormColorPickerView.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 22/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct FormColorPickerView: View {
  var title: String
  
  @Binding var value: Subject.CustomColor
  
  var body: some View {
    VStack {
      FormSectionTitle(title: title)
      
      HStack(alignment: .center, spacing: 12) {
        ForEach(Subject.CustomColor.allCases, id: \.self) { element in
          ZStack {
            Subject.getColor(subjectColor: element).dark
            
            if element == self.value {
              Image(systemName: "checkmark")
                .renderingMode(.template)
                .resizable()
                .frame(width: 14, height: 14)
                .scaledToFit()
                .foregroundStyle(Subject.getColor(subjectColor: element).light)
            }
          }
          .frame(width: 30, height: 30)
          .clipShape(Circle())
          .overlay(
            Circle()
              .stroke(Subject.getColor(subjectColor: element).light, lineWidth: 3)
          )
          .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            self.value = element
          })
          .accessibilityLabel(Text(NSLocalizedString(element.rawValue, comment: "")))
        }
        
        Spacer()
      }
    }
    .padding(.horizontal, 15)
  }
}

#Preview {
  FormColorPickerView(title: "Accent color", value: .constant(.purple))
}
