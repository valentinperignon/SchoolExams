//
//  GradesView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct GradesView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  @ObservedObject var subject: Subject
  
  @State private var displayEditView: Bool = false

  @State private var displayEditSheet: Bool = false
  @State private var displayNewSheet: Bool = false
  
  // MARK: Body
  
  var body: some View {
    Group {
      // Views : empty / grades
      if subject.grades.isEmpty {
          
        VStack {
          Spacer()
          
          Image("NothingToPrint")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .foregroundStyle(colorScheme == .light ? Color.mgPurpleLight : .appleDarkGray5)
            .accessibilityHidden(true)
          
          VStack {
            Text("No Grade")
              .font(.title)
              .fontWeight(.bold)
              .padding(.horizontal, 15)
            Text("You can add a grade to this subject")
              .foregroundStyle(Color.mgPurpleDark)
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
              Text("Sort by")
                .font(.callout)
                .foregroundStyle(colorScheme == .light ? Color.mgPurpleDark : .white)
                .fontWeight(.medium)
                .padding(.trailing, 1)
              
              Picker("Sort by", selection: $subject.sortBy) {
                ForEach(Subject.Order.allCases, id: \.self) { element in
                  Text(NSLocalizedString(element.rawValue, comment: ""))
                    .accessibilityValue(Text(Subject.getAccessibilityOrder(or: element)))
                }
              }
              .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal, 15)
            .padding(.top, -10)
            
            // ----- Subjects -----
            
            ForEach(subject.grades) { grade in
              NavigationLink {
                EditGradeView(
                  subject: self.subject,
                  grade: grade,
                  gradeValue: "\(grade.value)",
                  scaleValue: "\(grade.scale)"
                ).environmentObject(self.allSubjects)
              } label: {
                GradeListView(subject: self.subject, grade: grade)
                  .contextMenu {
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
                      Label("Remove", systemImage: "trash")
                    }
                  }
              }
              .tint(Color.black)
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
    .navigationTitle(Text(subject.name))
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: {
          self.displayEditView = true
        }) {
          Image(systemName: "gear")
            .resizable()
            .frame(width: 23, height: 23)
            .accessibilityLabel(Text("Edit the subject"))
        }
      }
    }
    .navigationDestination(isPresented: $displayEditView) {
      EditSubjectView(subject: subject)
        .environmentObject(allSubjects)
    }
    .sheet(isPresented: $displayNewSheet) {
      NewGradeView(subject: self.subject)
        .environmentObject(self.allSubjects)
    }
  }
}

#Preview {
  let subject = Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0)
  subject.grades.append(Grade(name: "Oral", value: 18, scale: 20, coefficient: 3, date: Date(), tag: 0))

  return GradesView(subject: subject).environmentObject(SubjectStore())
}
