//
//  NewGradeView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct NewGradeView: View {
  // MARK: Environment
  
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  // MARK: Properties
  
  @ObservedObject var subject: Subject
  
  @State private var name: String = ""
  @State private var value: String = ""
  @State private var coefficient: Double = 1
  @State private var date: Date = Date()
  
  @State private var showAlert = false
  @State private var alertType: Int = 0
  private let alertName = 1
  private let alertValue = 2
  
  // MARK: Body
  
  var body: some View {
    ScrollView {
      // ----- Title
      SheetHeaderView(title: "New Grade", subtitle: NSLocalizedString("Add a new grade to", comment: "") + " \(subject.name)")
      
      // ----- Form
      
      VStack {
        // Name
        FormTextFieldView(keyboardType: .default, title: "Grade Description", textValue: $name, onEditing: {_ in}, onCommit: {})
          .padding(.bottom, 10)
        
        // Value
        FormTextFieldView(keyboardType: .decimalPad, title: "Value", textValue: $value, onEditing: {_ in}, onCommit: {})
          .padding(.bottom, 10)
        
        // Coefficient
        FormStepperView(title: "Coefficient", value: $coefficient, range: 0.5...20, step: 0.5)
          .padding(.bottom, 10)
        
        // Date
        FormDatePickerView(title: "Date", selectedDate: $date)
        
        // Button Add
        ButtonFullWidth(type: .primary, title: "Add the Grade") {
          let feedbackGenerator = UINotificationFeedbackGenerator()
          feedbackGenerator.prepare()
          
          guard !self.name.isEmpty else {
            self.showAlert.toggle()
            self.alertType = self.alertName
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          guard
            !self.value.isEmpty,
            let valueDouble = Double(self.value.replacingOccurrences(of: ",", with: ".")),
            valueDouble >= 0,
            valueDouble <= 20
          else {
            self.showAlert.toggle()
            self.alertType = self.alertValue
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          feedbackGenerator.notificationOccurred(.success)
          
          self.subject.addGrade(
            name: self.name, value: valueDouble, coefficient: self.coefficient, date: self.date
          )
          self.allSubjects.saveJSON()
          self.subject.computeAverage()
          self.allSubjects.computeAverage()
          
          self.presentationMode.wrappedValue.dismiss()
        }
        .padding(.bottom)
      }
      
      Spacer()
    }
    .onTapGesture {
      self.hideKeyboard()
    }
    .alert(isPresented: $showAlert) {
      let message: Text
      
      if self.alertType == self.alertName {
        message = Text("The grade description can't be empty.")
      } else {
        message = Text("The value can't be empty and must be a number between 0 and 20.")
      }
      
      return Alert(
        title: Text("Something went wrong"),
        message: message,
        dismissButton: .default(Text("OK"))
      )
    }
  }
}

struct NewGradeView_Previews: PreviewProvider {
  static var previews: some View {
    NewGradeView(subject: Subject(name: "Anglais", color: .red, coefficient: 3))
      .environmentObject(SubjectStore())
  }
}
