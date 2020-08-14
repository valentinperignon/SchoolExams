//
//  NewSubjectView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 30/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct NewSubjectView: View {
  // MARK: Environment
  
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  // MARK: Properties
  
  @State private var name: String = ""
  @State private var coefficient: Double = 1
  @State private var accentColor: SubjectColor = .purple
  
  @State private var showAlert = false
  
  @State private var keyboardIsDisplayed = false
  
  // MARK: Body
  
  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        // ----- Title
        SheetHeaderView(title: "New Subject", subtitle: "Add a new subject to your list")
        
        // ----- Form
        
        VStack {
          // Name
          FormTextFieldView(keyboardType: .default, title: "Subject name", textValue: $name, onEditing: {_ in self.keyboardIsDisplayed = true}, onCommit: {self.keyboardIsDisplayed = false; print("\(self.keyboardIsDisplayed)")})
            .padding(.bottom, 10)
          
          // Coefficient
          FormStepperView(title: "Coefficient", value: $coefficient, range: 0.5...20, step: 0.5)
            .padding(.bottom, 10)
          
          // Accent color
          FormSegmentedPickerView(title: "Accent color", value: $accentColor)
            .padding(.bottom, 15)
          
          // Button
          ButtonFullWidth(type: .primary, title: "Add the Subject") {
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.prepare()
            
            guard !self.name.isEmpty else {
              self.showAlert.toggle()
              
              feedbackGenerator.notificationOccurred(.error)
              return
            }
            
            feedbackGenerator.notificationOccurred(.success)
            
            self.allSubjects.subjects.append(
              Subject(name: self.name, color: self.accentColor, coefficient: self.coefficient)
            )
            self.presentationMode.wrappedValue.dismiss()
          }
        }
        
        Spacer()
      }
      .alert(isPresented: $showAlert) {
        Alert(
          title: Text("Something went wrong"),
          message: Text("The name of the subject can't be empty."),
          dismissButton: .default(Text("OK"))
        )
      }
      
      if keyboardIsDisplayed {
        HStack {
          Spacer()
          
          Button(action: {
            self.hideKeyboard()
            self.keyboardIsDisplayed.toggle()
          }) {
            Image(systemName: "keyboard.chevron.compact.down")
              .renderingMode(.template)
              .foregroundColor(.white)
              .padding(.horizontal)
              .padding(.top, 20)
              .padding(.bottom, 15)
          }
          .background(Color.mgPurpleDark)
          .cornerRadius(5)
          .shadow(radius: 2)
          .padding(.top, 25)
          .padding(.trailing, 20)
        }
      }
    }
  }
}

struct NewSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    NewSubjectView()
    .environmentObject(SubjectStore())
  }
}
