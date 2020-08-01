//
//  GradesView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct GradesView: View {
  // MARK: Property
  
  @ObservedObject var subject: Subject
  
  @State private var displayEditSheet: Bool = false
  @State private var displayNewSheet: Bool = false
  
  // MARK: Body
  
  var body: some View {
    if subject.grades.isEmpty {
      
      VStack {
        Image("NothingToPrint")
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .padding(.horizontal, 40)
          .foregroundColor(.mgPurpleLight)
        
        Text("No Grade")
          .font(.title)
          .fontWeight(.bold)
        Text("You can add a grade to this subject")
          .foregroundColor(.mgPurpleDark)
      }
      .modifier(GradeViewNavigationModifier(subject: subject, subjectName: subject.name, editForm: $displayEditSheet, newForm: $displayNewSheet))
      
    } else {
      
      ScrollView {
        // ----- Average Grade -----
        ZStack {
          Rectangle()
            .fill(Color.mgPurpleLight)
            .clipShape(RoundedRectangle(radius: 20))
          
          AverageView(average: 14.5)
            .padding(.top, 5)
            .padding(.bottom, 18)
        }
        .padding(.bottom, 8)
        
        // ----- Subjects -----
        ForEach(subject.grades) { grade in
          NavigationLink(destination: EmptyView()) {
            GradeListView(subject: subject, grade: grade)
          }.accentColor(Color.black)
        }
        
        Spacer(minLength: 15)
      }
      .modifier(GradeViewNavigationModifier(subject: subject, subjectName: subject.name, editForm: $displayEditSheet, newForm: $displayNewSheet))
      
    }
  }
}

struct GradeViewNavigationModifier: ViewModifier {
  @ObservedObject var subject: Subject
  
  var subjectName: String
  
  @Binding var editForm: Bool
  @Binding var newForm: Bool
  
  func body(content: Content) -> some View {
    content
      .navigationBarTitle(
        Text(subjectName)
      )
      .navigationBarItems(trailing:
        HStack {
          Button(action: {
            editForm.toggle()
          }) {
            Image("Clogwheel")
              .resizable()
              .frame(width: 23, height: 23)
          }
          .padding(.trailing, 10)
          
          Button(action: {
            newForm.toggle()
          }) {
            Image(systemName: "plus")
          }
        }
      )
      .sheet(isPresented: $newForm, content: {
        NewGradeView(subject: subject)
      })
  }
}

struct GradesView_Previews: PreviewProvider {
  static var previews: some View {
    GradesView(subject: Subject(name: "Anglais", color: .red, coefficient: 3))
  }
}
