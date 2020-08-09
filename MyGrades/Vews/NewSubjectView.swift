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
  
  // MARK: Properties
  
  @ObservedObject var allSubjects: SubjectStore
  
  @State private var name: String = ""
  @State private var coefficient: Double = 1
  @State private var accentColor: SubjectColor = .purple
  
  @State private var showAlert = false
  
  // MARK: Body
  
  var body: some View {
    VStack {
      // ----- Title
      VStack {
        HStack {
          Text("New Subject")
            .font(.largeTitle)
            .fontWeight(.bold)
          Spacer()
        }
        HStack {
          Text("Add a new subject to your list")
            .font(.callout)
          Spacer()
        }
      }
      .padding([.horizontal, .bottom])
      .padding(.top, 60)
      .background(Color.mgPurpleLight)
      .padding(.bottom, 22)
      
      // ----- Form
      
      VStack {
        // Name
        FormTextFieldView(keyboardType: .default, title: "Subject Name", textValue: $name)
          .padding(.bottom, 10)
        
        // Coefficient
        FormStepperView(title: "Coefficient", value: $coefficient, range: 0.5...20, step: 0.5)
          .padding(.bottom, 10)
        
        
        
        // Accent color
        FormSegmentedPickerView(title: "Accent color", value: $accentColor)
          .padding(.bottom, 15)
        
        // Button
        ButtonFullWidth(type: .primary, title: "Add The Subject") {
          guard !self.name.isEmpty else {
            self.showAlert.toggle()
            return
          }
          
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
        message: Text("The subject must have a title"),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}

struct NewSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    NewSubjectView(allSubjects: SubjectStore())
  }
}
