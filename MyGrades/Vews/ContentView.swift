//
//  ContentView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 25/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  // MARK: Body
  
  var body: some View {
    
    NavigationView {
      ScrollView {
        // ----- Average Grade -----
        ZStack {
          Rectangle()
            .fill(Color.mgPurpleLight)
            .clipShape(RoundedRectangle(radius: 20))
          
          AverageView(average: 14.5)
            .padding(.vertical, 20)
        }
        .padding(.bottom, 15)
        
        // ----- Subjects -----
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
        SubjectListView(subject: .constant(Subject(name: "Langages du Web", color: .purple, coefficient: 6)))
      }
      .navigationBarTitle(
        Text("My Subjects")
          .foregroundColor(.black)
      )
      .navigationBarItems(trailing:
        Button(action: {}) {
          Image(systemName: "plus")
            .renderingMode(.original)
        }
      )
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

