//
//  EditGradeView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 11/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct EditGradeView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  @ObservedObject var subject: Subject
  @ObservedObject var grade: Grade
  
  @State var gradeValue: String
  @State var scaleValue: String
  
  @State private var showAlert = false
  
  var body: some View {
    ScrollView {
      Spacer(minLength: 20)
      
      // ----- Form
      
      // Value
      FormTextFieldView(keyboardType: .decimalPad, title: "Value", textValue: $gradeValue)
        .padding(.bottom, 10)
      
      // Scale
      FormTextFieldView(keyboardType: .decimalPad, title: "Scale", textValue: $scaleValue)
        .padding(.bottom, 10)
      
      // Name
       FormTextFieldView(keyboardType: .default, title: "Grade Description", textValue: $grade.name)
         .padding(.bottom, 10)
      
      // Coefficient
      FormStepperView(title: "Coefficient", value: $grade.coefficient, range: 0.5...20, step: 0.5)
        .padding(.bottom, 10)
      
      // Date
      FormDatePickerView(title: "Date", selectedDate: $grade.date)
      
      // Buttons Save & Cancel
      GeometryReader { geometry in
        // cancel
        ButtonFullWidth(type: .warning, title: "Back", iconSysName: "arrow.left") {
          self.allSubjects.loadJSON()
          self.presentationMode.wrappedValue.dismiss()
        }
        .frame(width: geometry.size.width/2+7.5, height: 70)
        
        // save
        ButtonFullWidth(type: .primary, title: "Save", iconSysName: "checkmark") {
          let feedbackGenerator = UINotificationFeedbackGenerator()
          feedbackGenerator.prepare()
          
          guard !self.grade.name.isEmpty else {
            Alert.mgType = .nameError
            self.showAlert.toggle()
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          // Scale can't be empty and must be a number
          guard
            !self.scaleValue.isEmpty,
            let scaleDouble = Double(self.scaleValue.replacingOccurrences(of: ",", with: ".")),
            scaleDouble > 0
          else {
            self.showAlert.toggle()
            Alert.mgType = .scaleError
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          // Grade value can't be empty and must be a number
          guard
            !self.gradeValue.isEmpty,
            let gradeValue = Double(self.gradeValue.replacingOccurrences(of: ",", with: ".")),
            gradeValue >= 0,
            gradeValue <= scaleDouble
          else {
            Alert.mgType = .valueError
            self.showAlert.toggle()
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          self.grade.scale = scaleDouble
          self.grade.value = gradeValue
          
          feedbackGenerator.notificationOccurred(.success)
          
          self.allSubjects.saveJSON()
          self.subject.computeAverage()
          self.allSubjects.computeAverage()
          if self.subject.sortBy != .defaultOrder {
            self.subject.sortGrades()
          }
          
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
        
        self.showAlert.toggle()
        Alert.mgType = .removeWarning
      }
      .padding(.bottom, 15)
    }
    .navigationBarTitle(Text("Edit the Grade"))
    .navigationBarBackButtonHidden(true)
    .alert(isPresented: $showAlert) {
      if Alert.mgType != .removeWarning {
        var message: Text
        if Alert.mgType == .nameError {
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
      subject: Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0),
      grade: Grade(name: "Oral", value: 18, scale: 20, coefficient: 1, date: Date(), tag: 0),
      gradeValue: "18.0", scaleValue: "20"
    )
    .environmentObject(SubjectStore())
  }
}
