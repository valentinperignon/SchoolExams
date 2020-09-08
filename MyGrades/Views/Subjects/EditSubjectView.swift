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
  @State private var action: Int? = 0
  
  // MARK: Body
  
  var body: some View {
    VStack {
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
          ButtonFullWidth(type: .warning, title: "Back", iconSysName: "gobackward") {
            self.allSubjects.loadJSON()
            self.presentationMode.wrappedValue.dismiss()
          }
            .frame(width: geometry.size.width/2+7.5, height: 50)
            .padding(.bottom, 20)
        
         // save
         ButtonFullWidth(type: .primary, title: "Save", iconSysName: "checkmark") {
           let feedbackGenerator = UINotificationFeedbackGenerator()
           feedbackGenerator.prepare()
           
           guard !self.subject.name.isEmpty else {
             Alert.mgType = .nameError
             self.showAlert.toggle()
             
             feedbackGenerator.notificationOccurred(.error)
             return
           }
           
           feedbackGenerator.notificationOccurred(.success)
           
           self.allSubjects.computeAverage()
           self.allSubjects.saveJSON()
           self.presentationMode.wrappedValue.dismiss()
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
         
         Alert.mgType = .removeWarning
         self.showAlert.toggle()
       }
     }
     .padding(.top, 20)
     
     Spacer(minLength: 20)
    }
    .navigationBarTitle(Text("Edit the Subject"))
    .navigationBarBackButtonHidden(true)
    .alert(isPresented: $showAlert) {
     if Alert.mgType == .nameError {
       return Alert(
         title: Text("Something went wrong"),
         message: Text("The name of the subject can't be empty."),
         dismissButton: .default(Text("OK"))
       )
     }
     
     return Alert(
       title: Text("Are you sure?"),
       message: Text("Do you really want to remove this subject?"),
       primaryButton: .destructive(Text("Remove"), action: {
         self.allSubjects.subjects.remove(at:
           self.allSubjects.subjects.firstIndex(of: self.subject)!
         )
         self.allSubjects.computeAverage()
         
        self.presentationMode.wrappedValue.dismiss()
       }),
       secondaryButton: .cancel()
     )
    }
  }
}

struct EditSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    EditSubjectView(subject: Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0))
    .environmentObject(SubjectStore())
  }
}
