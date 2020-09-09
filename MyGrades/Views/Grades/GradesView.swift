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
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Environment(\.presentationMode) var presentationMode
  
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
            .foregroundColor(colorScheme == .light ? .mgPurpleLight : .appleDarkGray5)
            .accessibility(hidden: true)
          
          VStack {
            Text("No Grade")
              .font(.title)
              .fontWeight(.bold)
              .padding(.horizontal, 15)
            Text("You can add a grade to this subject")
              .foregroundColor(.mgPurpleDark)
              .multilineTextAlignment(.center)
              .padding(.horizontal, 15)
          }
          .accessibilityElement(children: .combine)
          
          Spacer()
          
          ButtonFullWidth(type: .primary, title: "New Grade", iconSysName: "plus") {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            
            self.displayNewSheet.toggle()
          }
          .padding(.bottom, 30)
        }
          
      } else {
          
        ZStack(alignment: .bottomTrailing) {
          ScrollView {
            // ----- Average Grade -----
            
            AverageView(average: subject.averageDisplay)
            
            // ----- Sort tool -----
            
            HStack {
              Text("SORT BY")
                .font(.callout)
                .foregroundColor(colorScheme == .light ? .mgPurpleDark : .white)
                .fontWeight(.medium)
                .padding(.trailing, 1)
              
              Picker("Sort by", selection: $subject.sortBy) {
                ForEach(Subject.Order.allCases, id: \.self) { element in
                  Text(NSLocalizedString(element.rawValue, comment: ""))
                }
              }
              .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal, 15)
            .padding(.top, -10)
            
            // ----- Subjects -----
            
            ForEach(subject.grades) { grade in
              NavigationLink(destination:
                EditGradeView(
                  subject: self.subject,
                  grade: grade,
                  gradeValue: "\(grade.value)",
                  scaleValue: "\(grade.scale)"
                ).environmentObject(self.allSubjects)
              ) {
                GradeListView(subject: self.subject, grade: grade)
                  .contextMenu(
                    ContextMenu {
                      Button(action: {
                        let feedbackGenerator = UINotificationFeedbackGenerator()
                        feedbackGenerator.notificationOccurred(.success)
                        
                        self.subject.grades.remove(at:
                          self.subject.grades.firstIndex(of: grade)!
                        )
                        self.allSubjects.saveJSON()
                        
                        self.subject.computeAverage()
                        self.allSubjects.computeAverage()
                      }) {
                        Text("Remove")
                        Image(systemName: "trash")
                      }
                    }
                  )
              }
              .accentColor(Color.black)
              .buttonStyle(ButtonListStyle())
              .padding(.horizontal, 10)
              .padding(.bottom, -12)
            }
            
            Spacer(minLength: 15)
          }
          
          // ----- New Grade Button -----
          
          ButtonCircle {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            
            self.displayNewSheet.toggle()
          }
        }
          
      }
    }
    .navigationBarTitle(Text(subject.name))
    .navigationBarItems(trailing:
      NavigationLink(destination: EditSubjectView(subject: subject).environmentObject(allSubjects)) {
        Button(action: {
          self.action = 1
        }) {
          Image(systemName: "gear")
            .resizable()
            .frame(width: 23, height: 23)
            .accessibility(label: Text("Edit the subject"))
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
    let subject = Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0)
    subject.grades.append(Grade(name: "Oral", value: 18, scale: 20, coefficient: 3, date: Date(), tag: 0))
    
    return GradesView(subject: subject).environmentObject(SubjectStore())
  }
}
