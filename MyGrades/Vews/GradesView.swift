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
    Group {
      if subject.grades.isEmpty {
          
        VStack {
          Spacer()
          
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
          
          Spacer()
          
          ButtonFullWidth(type: .primary, title: "New Grade", iconSysName: "plus") {
            self.displayNewSheet.toggle()
          }
          .padding(.bottom, 30)
        }
          
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
          
          // ----- Button -----
          ButtonFullWidth(type: .primary, title: "New Grade", iconSysName: "plus") {
            self.displayNewSheet.toggle()
          }
          
          // ----- Subjects -----
          ForEach(subject.grades) { grade in
            NavigationLink(destination: EmptyView()) {
              GradeListView(subject: self.subject, grade: grade)
            }.accentColor(Color.black)
          }
          
          Spacer(minLength: 15)
        }
          
      }
    }
  .modifier(GradeViewNavigationModifier(subject: subject, editForm: $displayEditSheet, newForm: $displayNewSheet))
  }
}

struct GradeViewNavigationModifier: ViewModifier {
  @ObservedObject var subject: Subject
  
  @Binding var editForm: Bool
  @Binding var newForm: Bool
  
  func body(content: Content) -> some View {
    content
      .navigationBarTitle(Text(subject.name))
      .navigationBarItems(trailing:
        HStack {
          Button(action: {
            self.editForm.toggle()
          }) {
            Image("Clogwheel")
              .resizable()
              .frame(width: 23, height: 23)
          }
        }
      )
      .sheet(isPresented: $newForm, content: {
        NewGradeView(subject: self.subject)
      })
  }
}

struct GradesView_Previews: PreviewProvider {
  static var previews: some View {
    GradesView(subject: Subject(name: "Anglais", color: .red, coefficient: 3))
  }
}
