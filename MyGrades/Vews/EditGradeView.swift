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
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  // MARK: Property
  
  @ObservedObject var subject: Subject
  @ObservedObject var grade: Grade
  
  @State var gradeValue: String
  
  @State private var displayAlert = false
  @State private var alertType = 0
  private let alertName = 1
  private let alertValue = 2
  
  // MARK: Body
  
  var body: some View {
    ScrollView {
      Spacer(minLength: 20)
      
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
      
      // Buttons Save & Cancel
      GeometryReader { geometry in
        // save
        ButtonFullWidth(type: .primary, title: "Save", iconSysName: "checkmark") {
          guard !self.grade.name.isEmpty else {
            self.alertType = self.alertName
            self.displayAlert.toggle()
            return
          }
          
          guard let gradeValue = Double(self.gradeValue) else {
            self.alertType = self.alertValue
            self.displayAlert.toggle()
            return
          }
          self.grade.value = gradeValue
          
          self.allSubjects.saveJSON()
          self.subject.computeAverage()
          self.allSubjects.computeAverage()
          
          self.presentationMode.wrappedValue.dismiss()
        }
          .frame(width: geometry.size.width/2+7.5, height: 70)
        // cancel
        ButtonFullWidth(type: .warning, title: "Cancel", iconSysName: "gobackward") {
          self.allSubjects.loadJSON()
          self.presentationMode.wrappedValue.dismiss()
        }
          .frame(width: geometry.size.width/2+7.5, height: 70)
          .offset(x: geometry.size.width/2-7.5)
      }
      
      Spacer(minLength: 65)
      
      // Button remove
      ButtonFullWidth(type: .alert, title: "Remove", iconSysName: "trash") {
        self.subject.grades.remove(at:
          self.subject.grades.firstIndex(of: self.grade)!
        )
        self.allSubjects.saveJSON()
        
        self.presentationMode.wrappedValue.dismiss()
      }
      .padding(.bottom, 15)
    }
    .navigationBarTitle(Text("Edit The Grade"))
    .navigationBarBackButtonHidden(true)
    .alert(isPresented: $displayAlert) {
      var message: Text
      if self.alertType == self.alertName {
        message = Text("The name of your grade can't be empty")
      } else {
        message = Text("The value can't be empty and must be a number")
      }
      
      return Alert(
        title: Text("Something went wrong"),
        message: message,
        dismissButton: .default(Text("OK"))
      )
    }
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
