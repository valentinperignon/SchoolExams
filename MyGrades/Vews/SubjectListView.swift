//
//  SubjectListView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct SubjectListView: View {
  // MARK: Properties
  
  @Binding var subject: Subject
  
  // MARK: Body
  var body: some View {
    HStack {
      // ----- Average grade
      ZStack {
        Color.mgPurpleLight
        
        Text("14.5")
      }
      .frame(width: 65, height: 65)
      .cornerRadius(15)
      .padding(.trailing, 10)
      
      // ----- About
      VStack {
        HStack {
          Text(subject.name)
            .font(.headline)
            .padding(.bottom, 8)
          Spacer()
        }
        
        HStack {
          Text("coeff. \(subject.coefficient.description)")
            .font(.callout)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Color.mgPurpleDark)
            .cornerRadius(7)
          Spacer()
        }
      }
      
      Spacer()
      
      // ----- Link to edit
      NavigationLink(destination: EmptyView()) {
        Image("Edit")
          .resizable()
          .frame(width: 55, height: 55)
          .accentColor(Color.mgPurpleDark)
      }
    }
    .padding(.horizontal, 15)
  }
}

struct SubjectListView_Previews: PreviewProvider {
  static var previews: some View {
    SubjectListView(subject: .constant(
      Subject(name: "Langages du Web", color: .purple, coefficient: 6)
    ))
  }
}
