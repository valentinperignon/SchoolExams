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
      .padding(.bottom)
      
      // ----- Form
      
      VStack {
        // Name
        FormTextFieldView(title: "Subject Name", textValue: $name)
          .padding(.bottom, 8)
        
        // Coefficient
        VStack {
          HStack {
            Text("Coefficient")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.mgPurpleDark)
            Spacer()
          }
          
          Stepper(
            onIncrement: {
              self.coefficient += 0.5
            },
            onDecrement: {
              if self.coefficient > 0.5 {
                self.coefficient -= 0.5
              }
            }, label: {
              Text("\(self.coefficient.description)")
            }
          )
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 8)
        
        // Accent color
        VStack {
          HStack {
            Text("Accent Color")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.mgPurpleDark)
            Spacer()
          }
          
          Picker("", selection: $accentColor) {
            ForEach(SubjectColor.allCases, id: \.self) { color in
              Text(color.rawValue)
            }
          }
        .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
        
        // Button
        Button(action: {
          self.allSubjects.subjects.append(
            Subject(name: self.name, color: self.accentColor, coefficient: self.coefficient)
          )
          self.presentationMode.wrappedValue.dismiss()
        }) {
          HStack {
            Spacer()
            Text("Add this subject")
            Spacer()
          }
        }
        .accentColor(.primary)
        .padding(.vertical, 10)
        .background(Color.mgPurpleLight)
        .cornerRadius(10)
        .padding(.horizontal,15)
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
