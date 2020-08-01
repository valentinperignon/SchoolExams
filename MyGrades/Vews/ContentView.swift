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
  
  @ObservedObject var allSubjects: SubjectStore
  
  @State private var showNewSubjectSheet = false
  
  // MARK: Body
  
  var body: some View {
    
    NavigationView {
      
      if allSubjects.subjects.isEmpty {
        
        VStack {
          Image("NothingToPrint")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .foregroundColor(.mgPurpleLight)
          
          Text("No Subject")
            .font(.title)
            .fontWeight(.bold)
          Text("You need to add at least one subject")
            .foregroundColor(.mgPurpleDark)
        }
        .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
        
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
          ForEach(allSubjects.subjects) { subject in
            NavigationLink(destination: GradesView(subject: subject)) {
              SubjectListView(subject: subject)
            }.accentColor(Color.black)
          }
          
          Spacer(minLength: 15)
        }
        .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
      }
      
    }
    .sheet(isPresented: $showNewSubjectSheet) {
      NewSubjectView(allSubjects: self.allSubjects)
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
      .navigationBarItems(trailing:
        Button(action: {
          self.displaySheet.toggle()
        }) {
          Image(systemName: "plus")
        }
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(allSubjects: SubjectStore.getDemoData())
  }
}
