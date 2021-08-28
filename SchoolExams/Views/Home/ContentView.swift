//
//  ContentView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 25/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @EnvironmentObject var allSubjects: SubjectStore
  @State var showNewSubjectSheet = false
  
  var body: some View {
    NavigationView {
      
      if allSubjects.subjects.isEmpty {
        NoSubjectView(showSheet: $showNewSubjectSheet)
          .padding(.horizontal, 15)
          .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
      } else {
        ZStack(alignment: .bottomTrailing) {
          ShowSubjectsView()
            .environmentObject(allSubjects)
            .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
          
          ButtonCircle {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            showNewSubjectSheet.toggle()
          }
        }
      }
      
    }
    .sheet(isPresented: $showNewSubjectSheet) {
      NewSubjectView().environmentObject(self.allSubjects)
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
