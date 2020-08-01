//
//  GradeListView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct GradeListView: View {
  // MARK: Properties
  
  var subject: Subject
  var grade: Grade
  
  // MARK: Body
  var body: some View {
    HStack {
      // ----- Average grade
      ZStack {
        subject.getColor()
        
        Text("14.5")
      }
      .frame(width: 65, height: 65)
      .cornerRadius(15)
      .padding(.trailing, 5)
      
      // ----- About
      VStack {
        HStack {
          Text(grade.name)
            .font(.headline)
            .padding(.bottom, 8)
          Spacer()
        }
        
        HStack {
          Text("coeff. \(grade.coefficient.description)")
            .font(.callout)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(subject.getColor())
            .cornerRadius(7)
          Spacer()
        }
      }
      
      Spacer()
      
      // ----- Link to edit
      Image("Edit")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(subject.getColor())
        .frame(width: 40, height: 40)
        .contrast(0.80)
    }
    .padding(.horizontal, 15)
  }
}

struct GradeListView_Previews: PreviewProvider {
  static var previews: some View {
    GradeListView(
      subject: Subject(name: "Anglais", color: .red, coefficient: 3),
      grade: Grade(name: "Exposé", value: 18, coefficient: 2)
    )
  }
}
