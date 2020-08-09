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
  
  var subject: Subject
  
  // MARK: Body
  var body: some View {
    HStack {
      // ----- Average grade
      ZStack {
        subject.getColor().dark
        
        Text("14.5")
          .fontWeight(.heavy)
          .foregroundColor(.white)
      }
      .frame(width: 65, height: 65)
      .cornerRadius(15)
      .padding(.trailing, 5)
      
      // ----- About
      VStack {
        HStack {
          Text(subject.name)
            .font(.headline)
            .fontWeight(.medium)
            .padding(.bottom, 8)
          Spacer()
        }
        
        HStack {
          Text("coeff. \(subject.coefficient.description)")
            .font(.callout)
            .fontWeight(.light)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(subject.getColor().light)
            .cornerRadius(7)
          Spacer()
        }
      }
      
      Spacer()
      
      // ----- Link to edit
      Image("ArrowRight")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(subject.getColor().dark)
        .frame(width: 37, height: 37)
        .contrast(0.95)
        .brightness(0.01)
    }
    .padding(.horizontal, 15)
  }
}

struct SubjectListView_Previews: PreviewProvider {
  static var previews: some View {
    SubjectListView(subject:
      Subject(name: "Langages du Web", color: .purple, coefficient: 6)
    )
  }
}
