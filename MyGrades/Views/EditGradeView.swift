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
  @State private var alertType: Alert.MyGradeType?
  
  // MARK: Body
  
  var body: some View {
    ScrollView {
      Spacer(minLength: 20)
      
      // ----- Form
      
      // Name
      FormTextFieldView(keyboardType: .default, title: "Grade Description", textValue: $grade.name, onEditing: {_ in}, onCommit: {})
        .padding(.bottom, 10)
      
      // Value
      FormTextFieldView(keyboardType: .decimalPad, title: "Value", textValue: $gradeValue, onEditing: {_ in}, onCommit: {})
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
          let feedbackGenerator = UINotificationFeedbackGenerator()
          feedbackGenerator.prepare()
          
          guard !self.grade.name.isEmpty else {
            self.alertType = .nameError
            self.displayAlert.toggle()
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          guard
            !self.gradeValue.isEmpty,
            let gradeValue = Double(self.gradeValue.replacingOccurrences(of: ",", with: ".")),
            gradeValue >= 0,
            gradeValue <= 20
          else {
            self.alertType = .valueError
            self.displayAlert.toggle()
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          self.grade.value = gradeValue
          
          feedbackGenerator.notificationOccurred(.success)
          
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
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.warning)
        
        self.displayAlert.toggle()
        self.alertType = .removeWarning
      }
      .padding(.bottom, 15)
    }
    .onTapGesture {
      self.hideKeyboard()
    }
    .navigationBarTitle(Text("Edit The Grade"))
    .navigationBarBackButtonHidden(true)
    .alert(isPresented: $displayAlert) {
      if self.alertType != .removeWarning {
        var message: Text
        if self.alertType == .nameError {
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
      
      return Alert(
        title: Text("Are you sure?"),
        message: Text("Do you really want to remove this grade?"),
        primaryButton: .destructive(Text("Remove"), action: {
          self.subject.grades.remove(at:
            self.subject.grades.firstIndex(of: self.grade)!
          )
          self.allSubjects.saveJSON()
          
          self.subject.computeAverage()
          self.allSubjects.computeAverage()
          
          self.presentationMode.wrappedValue.dismiss()
        }),
        secondaryButton: .cancel()
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
