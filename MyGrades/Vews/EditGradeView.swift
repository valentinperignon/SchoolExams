//
//  EditGradeView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 11/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct EditGradeView: View {
  // MARK: Environment
  
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var allSujects: SubjectStore
  
  // MARK: Property
  
  @ObservedObject var subject: Subject
  @ObservedObject var grade: Grade
  
  @State var gradeValue: String
  
  // MARK: Body
  
  var body: some View {
    VStack {
      // ----- Form
      
      // Name
      FormTextFieldView(keyboardType: .default, title: "Name", textValue: $grade.name)
        .padding(.bottom, 10)
      
      // Value
      FormTextFieldView(keyboardType: .decimalPad, title: "Value", textValue: $gradeValue)
        .padding(.bottom, 10)
      
      // Coefficient
      FormStepperView(title: "Coefficient", value: $grade.coefficient, range: 0.5...20, step: 0.5)
        .padding(.bottom, 10)
      
      // Date
      FormDatePickerView(title: "Date", selectedDate: $grade.date)
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
    }
    .padding(.top, 20)
    .navigationBarTitle(Text("Edit the grade"))
    .navigationBarBackButtonHidden(true)
  }
}

struct EditGradeView_Previews: PreviewProvider {
  static var previews: some View {
    EditGradeView(
      subject: Subject(name: "Anglais", color: .red, coefficient: 3),
      grade: Grade(name: "Oral", value: 18, coefficient: 1, date: Date()),
      gradeValue: "18.0"
    )
    .environmentObject(SubjectStore())
  }
}
