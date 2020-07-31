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
        FormTextFieldView(title: "Subject Name", textValue: $name)
          .padding(.bottom, 10)
        
        // Coefficient
        FormStepperView(
          title: "Coefficient",
          value: $coefficient,
          incrementAction: {
            self.coefficient += 0.5
          },
          decrementAction: {
            if self.coefficient > 0.5 {
              self.coefficient -= 0.5
            }
          }
        )
          .padding(.bottom, 10)
        
        // Accent color
        FormSegmentedPickerView(title: "Accent color", value: $accentColor)
          .padding(.bottom, 15)
        
        // Button
        FormButtonView(label: "Add the Subject") {
          self.allSubjects.subjects.append(
            Subject(name: self.name, color: self.accentColor, coefficient: self.coefficient)
          )
          self.presentationMode.wrappedValue.dismiss()
        }
      }
      
      Spacer()
    }
  }
}

struct NewSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    NewSubjectView(allSubjects: SubjectStore())
  }
}
