//
//  GradesView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct GradesView: View {
  // MARK: Environment
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  // MARK: Property
  
  @ObservedObject var subject: Subject
  
  @State private var action: Int? = 0
  
  @State private var displayEditSheet: Bool = false
  @State private var displayNewSheet: Bool = false
  
  // MARK: Body
  
  var body: some View {
    Group {
      // NavigationLink for Edit page
      
      NavigationLink(
        destination:
          EditSubjectView(subject: subject)
            .environmentObject(allSubjects),
        tag: 1,
        selection: $action
      ) {
        EmptyView()
      }
      
      // Views : empty / grades
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
            
            AverageView(average: subject.averageToString())
              .padding(.top, 5)
              .padding(.bottom, 18)
          }
          .padding(.bottom, 4)
          
          // ----- Button -----
          ButtonFullWidth(type: .primary, title: "New Grade", iconSysName: "plus") {
            self.displayNewSheet.toggle()
          }
          
          // ----- Subjects -----
          ForEach(subject.grades) { grade in
            NavigationLink(destination:
              EditGradeView(subject: self.subject, grade: grade, gradeValue: "\(grade.value)").environmentObject(self.allSubjects)
            ) {
              GradeListView(subject: self.subject, grade: grade)
            }.accentColor(Color.black)
          }
          
          Spacer(minLength: 15)
        }
          
      }
    }
    .navigationBarTitle(Text(subject.name))
    .navigationBarItems(trailing:
      NavigationLink(destination: EditSubjectView(subject: subject).environmentObject(allSubjects)) {
        Button(action: {
          self.action = 1
        }) {
          Image("Clogwheel")
            .resizable()
            .frame(width: 23, height: 23)
        }
      }
    )
    .sheet(isPresented: $displayNewSheet) {
      NewGradeView(subject: self.subject)
        .environmentObject(self.allSubjects)
    }
  }
}

struct GradesView_Previews: PreviewProvider {
  static var previews: some View {
    let subject = Subject(name: "Anglais", color: .red, coefficient: 3)
    subject.grades.append(Grade(name: "Oral", value: 18, coefficient: 3, date: Date()))
    
    return GradesView(subject: subject).environmentObject(SubjectStore())
  }
}
