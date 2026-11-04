//
//  NewGradeView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct NewGradeView: View {
  @Environment(\.dismiss) private var dismiss
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  @ObservedObject var subject: Subject
  
  @State private var name: String = ""
  @State private var value: String = ""
  @State private var scale: String = "20"
  @State private var coefficient: Double = 1
  @State private var date: Date = Date()
  
  @State private var showAlert = false
  @State private var alertType: MGAlertType?

  var body: some View {
    ScrollView {
      // ----- Title
      SheetHeaderView(title: "New Grade", subtitle: NSLocalizedString("Add a new grade to", comment: "") + " \(subject.name)")
      
      // ----- Form
      
      VStack {
        // Value
        FormTextFieldView(keyboardType: .decimalPad, title: "Value", textValue: $value)
          .padding(.bottom, 10)
        
        // Scale
        FormTextFieldView(keyboardType: .decimalPad, title: "Scale", textValue: $scale)
          .padding(.bottom, 10)
        
        // Name
        FormTextFieldView(keyboardType: .default, title: "Grade Description", textValue: $name)
          .padding(.bottom, 10)
        
        // Coefficient
        FormStepperView(title: "Coefficient", value: $coefficient, range: 0.5...20, step: 0.5)
          .padding(.bottom, 10)
        
        // Date
        FormDatePickerView(title: "Date", selectedDate: $date)
        
        // Button Add
        ButtonFullWidth(type: .primary, title: "Add the Grade", iconSysName: "checkmark") {
          let feedbackGenerator = UINotificationFeedbackGenerator()
          feedbackGenerator.prepare()
          
          // Name can"t be empty
          guard !self.name.isEmpty else {
            self.showAlert.toggle()
            self.alertType = .nameError
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          // Scale can't be empty and must be a number
          guard
            !self.scale.isEmpty,
            let scaleDouble = Double(self.scale.replacingOccurrences(of: ",", with: ".")),
            scaleDouble > 0
          else {
            self.showAlert.toggle()
            self.alertType = .scaleError
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          // Grade value can't be empty and must be a number
          guard
            !self.value.isEmpty,
            let valueDouble = Double(self.value.replacingOccurrences(of: ",", with: ".")),
            valueDouble >= 0,
            valueDouble <= scaleDouble
          else {
            self.showAlert.toggle()
            self.alertType = .valueError
            
            feedbackGenerator.notificationOccurred(.error)
            return
          }
          
          feedbackGenerator.notificationOccurred(.success)
          
          self.subject.addGrade(
            name: self.name, value: valueDouble, scale: scaleDouble, coefficient: self.coefficient, date: self.date
          )
          self.allSubjects.saveJSON()
          self.subject.computeAverage()
          self.allSubjects.computeAverage()
          
          self.dismiss()
            
          if valueDouble >= scaleDouble / 2.0 {
            AppStoreReviewManager.requestReviewIfPossible()
          }
        }
        .padding(.bottom)
      }
      
      Spacer()
    }
    .alert(alertType?.title ?? "", isPresented: $showAlert, presenting: alertType) { _ in
      Button("OK") {}
    } message: { type in
      switch type {
      case .nameError:
        Text("The grade description can't be empty.")
      case .valueError:
        let scaleDouble = Double(self.scale.replacingOccurrences(of: ",", with: ".")) ?? 0
        Text(NSLocalizedString("The value can't be empty and must be a number between 0 and", comment: "") + " \(scaleDouble).")
      case .scaleError:
        Text("The scale can't be empty and must be a number greater than 0.")
      case .removeWarning:
        Text("Unknown error.")
      }
    }
}
}

#Preview {
  NewGradeView(subject: Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0))
    .environmentObject(SubjectStore())
}
