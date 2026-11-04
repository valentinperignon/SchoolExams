//
//  EditSubjectView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 10/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct EditSubjectView: View {
  @Environment(\.dismiss) private var dismiss
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  @ObservedObject var subject: Subject
  
  @State private var showAlert = false
  @State private var alertType: MGAlertType?
@State private var action: Int? = 0
  
  var body: some View {
    ScrollView {
      // ----- Form
      VStack {
        // Name
        FormTextFieldView(keyboardType: .default, title: "Subject name", textValue: $subject.name)
          .padding(.bottom, 10)
        
        // Coefficient
        FormStepperView(title: "Coefficient", value: $subject.coefficient, range: 0.5...20, step: 0.5)
          .padding(.bottom, 10)
        
        // Accent color
        FormColorPickerView(title: "Accent color", value: $subject.color)
          .padding(.bottom, 10)
        
        // Options
        FormSectionTitle(title: "Option")
          .padding(.horizontal, 15)
        // Toggle
        Toggle(isOn: $subject.includedInOverall) {
          Text("Include in overall average")
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
        
        // Buttons Save & Cancel
        GeometryReader { geometry in
          // cancel
          ButtonFullWidth(type: .warning, title: "Back", iconSysName: "arrow.left") {
            self.allSubjects.loadJSON()
            self.dismiss()
          }
          .frame(width: geometry.size.width/2+7.5, height: 50)
          .padding(.bottom, 20)
          
          // save
          ButtonFullWidth(type: .primary, title: "Save", iconSysName: "checkmark") {
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.prepare()
            
            guard !self.subject.name.isEmpty else {
              self.alertType = .nameError
              self.showAlert.toggle()
              
              feedbackGenerator.notificationOccurred(.error)
              return
            }
            
            feedbackGenerator.notificationOccurred(.success)
            
            self.allSubjects.computeAverage()
            self.allSubjects.saveJSON()
            self.dismiss()
          }
          .frame(width: geometry.size.width/2+7.5, height: 50)
          .offset(x: geometry.size.width/2-7.5)
          .padding(.bottom, 20)
        }
        .frame(height: 60)
        
        // Button Remove
        ButtonFullWidth(type: .alert, title: "Remove", iconSysName: "trash") {
          let feedbackGenerator = UINotificationFeedbackGenerator()
          feedbackGenerator.notificationOccurred(.warning)
          
          self.alertType = .removeWarning
          self.showAlert.toggle()
        }
      }
      .padding(.top, 20)
      
      Spacer(minLength: 20)
    }
    .navigationTitle(Text("Edit the Subject"))
    .navigationBarBackButtonHidden(true)
    .alert(alertType?.title ?? "", isPresented: $showAlert, presenting: alertType) { type in
      if type == .removeWarning {
        Button("Remove", role: .destructive) {
          self.allSubjects.subjects.remove(at:
            self.allSubjects.subjects.firstIndex(of: self.subject)!
          )
          self.allSubjects.computeAverage()

          self.dismiss()
        }
        Button("Cancel", role: .cancel) {}
      } else {
        Button("OK") {}
      }
    } message: { type in
      if type == .removeWarning {
        Text("Do you really want to remove this subject?")
      } else {
        Text("The name of the subject can't be empty.")
      }
    }
}
}

#Preview {
  EditSubjectView(subject: Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0))
    .environmentObject(SubjectStore())
}
