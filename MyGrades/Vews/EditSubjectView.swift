//
//  EditSubjectView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 10/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct EditSubjectView: View {
  // MARK: Environment
  
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var allSujects: SubjectStore
  
  // MARK: Property
  
  @ObservedObject var subject: Subject
  
  // MARK: Body
  
  var body: some View {
    VStack {
      // ----- Form
      VStack {
        // Name
        FormTextFieldView(keyboardType: .default, title: "Name", textValue: $subject.name)
          .padding(.bottom, 10)
        
        // Coefficient
        FormStepperView(title: "Coefficient", value: $subject.coefficient, range: 0.5...20, step: 0.5)
          .padding(.bottom, 10)
        
        // Color
        FormSegmentedPickerView(title: "Color", value: $subject.color)
          .padding(.bottom, 15)
        
        // Buttons Save & Cancel
        GeometryReader { geometry in
          ButtonFullWidth(type: .primary, title: "Save", iconSysName: "checkmark") {
            self.allSujects.saveJSON()
            self.presentationMode.wrappedValue.dismiss()
          }
            .frame(width: geometry.size.width/2+7.5)
            .padding(.bottom, 20)
          ButtonFullWidth(type: .warning, title: "Cancel", iconSysName: "gobackward") {
            self.allSujects.loadJSON()
            self.presentationMode.wrappedValue.dismiss()
          }
            .frame(width: geometry.size.width/2+7.5)
            .offset(x: geometry.size.width/2-7.5)
            .padding(.bottom, 20)
        }
        
        // Button Remove
        ButtonFullWidth(type: .alert, title: "Remove", iconSysName: "trash") {
          self.allSujects.subjects.remove(at:
            self.allSujects.subjects.firstIndex(of: self.subject)!
          )
          self.presentationMode.wrappedValue.dismiss()
        }
      }
      .padding(.top, 20)
      
      Spacer(minLength: 20)
    }
    .navigationBarTitle(Text("Edit the subject"))
    .navigationBarBackButtonHidden(true)
  }
}

struct EditSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    EditSubjectView(subject: Subject(name: "Anglais", color: .red, coefficient: 3))
    .environmentObject(SubjectStore())
  }
}
