//
//  ContentView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 25/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  // MARK: Properties
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  @State private var showNewSubjectSheet = false
  
  // MARK: Body
  
  var body: some View {
    
    NavigationView {
      
      if allSubjects.subjects.isEmpty {
        
        VStack {
          Spacer()
          
          Image("NothingToPrint")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .foregroundColor(.mgPurpleLight)
            .accessibility(hidden: true)
          
          VStack {
            Text("No Subject")
              .font(.title)
              .fontWeight(.bold)
            Text("You need to add at least one subject")
              .foregroundColor(.mgPurpleDark)
              .multilineTextAlignment(.center)
          }
          .accessibilityElement(children: .combine)
          
          Spacer()
          
          ButtonFullWidth(type: .primary, title: "New Subject", iconSysName: "plus") {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            
            self.showNewSubjectSheet.toggle()
          }
          .padding(.bottom, 30)
        }
        .padding(.horizontal, 15)
        .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
        
      } else {
        
        ZStack(alignment: .bottomTrailing) {
          ScrollView {
            // ----- Average Grade -----
            
            AverageView(average: allSubjects.averageDisplay)
            
            // ----- Sort tool -----
            
            HStack {
              Text("SORT BY")
                .font(.callout)
                .foregroundColor(.mgPurpleDark)
                .fontWeight(.medium)
                .padding(.trailing, 1)
              
              Picker("Sort by", selection: $allSubjects.sortBy) {
                ForEach(SubjectStore.Order.allCases, id: \.self) { element in
                  Text(element.rawValue)
                }
              }
              .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal, 15)
            .padding(.top, -10)
            
            // ----- Subjects -----
            
            ForEach(allSubjects.subjects) { subject in
              NavigationLink(destination: GradesView(subject: subject).environmentObject(self.allSubjects)) {
                SubjectListView(subject: subject)
                  .environmentObject(self.allSubjects)
                  .contextMenu(
                    ContextMenu {
                      Button(action: {
                        let feedbackGenerator = UINotificationFeedbackGenerator()
                        feedbackGenerator.notificationOccurred(.success)
                        
                        self.allSubjects.subjects.remove(at:
                          self.allSubjects.subjects.firstIndex(of: subject)!
                        )
                        self.allSubjects.computeAverage()
                      }) {
                        Text("Remove")
                        Image(systemName: "trash")
                      }
                    }
                  )
              }
              .accentColor(Color.black)
              .padding(.horizontal, 15)
            }
            
            Spacer(minLength: 25)
          }
          .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
          
          // ----- New Subject Button -----
          
          ButtonCircle {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            
            self.showNewSubjectSheet.toggle()
          }
        }
      }
        
    }
    .sheet(isPresented: $showNewSubjectSheet) {
      NewSubjectView()
        .environmentObject(self.allSubjects)
    }
    
  }
}

struct ContentViewNavigationModifier: ViewModifier {
  @Binding var displaySheet: Bool
  
  func body(content: Content) -> some View {
    content
      .navigationBarTitle(
        Text("My Subjects")
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let store = SubjectStore()
    store.subjects.append(Subject(name: "Test", color: .orange, coefficient: 1, tag: 1))
    
    return ContentView()
      .environmentObject(store)
  }
}
