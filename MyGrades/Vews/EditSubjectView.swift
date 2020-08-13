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
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  // MARK: Property
  
  @ObservedObject var subject: Subject
  
  @State private var showAlert = false
  
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
          // save
          ButtonFullWidth(type: .primary, title: "Save", iconSysName: "checkmark") {
            guard !self.subject.name.isEmpty else {
              self.showAlert.toggle()
              return
            }
            
            let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
            hapticFeedback.impactOccurred()
            
            self.allSubjects.saveJSON()
            self.presentationMode.wrappedValue.dismiss()
          }
            .frame(width: geometry.size.width/2+7.5, height: 50)
            .padding(.bottom, 20)
          
          // cancel
          ButtonFullWidth(type: .warning, title: "Cancel", iconSysName: "gobackward") {
            self.allSubjects.loadJSON()
            self.presentationMode.wrappedValue.dismiss()
          }
            .frame(width: geometry.size.width/2+7.5, height: 50)
            .offset(x: geometry.size.width/2-7.5)
            .padding(.bottom, 20)
        }
        .frame(height: 60)
        
        // Button Remove
        ButtonFullWidth(type: .alert, title: "Remove", iconSysName: "trash") {
          let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
          hapticFeedback.impactOccurred()
          
          self.allSubjects.subjects.remove(at:
            self.allSubjects.subjects.firstIndex(of: self.subject)!
          )
          self.allSubjects.computeAverage()
          
          self.presentationMode.wrappedValue.dismiss()
        }
      }
      .padding(.top, 20)
      
      Spacer(minLength: 20)
    }
    .navigationBarTitle(Text("Edit The Subject"))
    .navigationBarBackButtonHidden(true)
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text("Something went wrong"),
        message: Text("The subject must have a title"),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}

struct EditSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    EditSubjectView(subject: Subject(name: "Anglais", color: .red, coefficient: 3))
    .environmentObject(SubjectStore())
  }
}
