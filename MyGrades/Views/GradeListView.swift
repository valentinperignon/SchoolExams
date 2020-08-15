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
  
  @ObservedObject var subject: Subject
  @ObservedObject var grade: Grade
  
  // MARK: Body
  
  var body: some View {
    HStack {
      // ----- Average grade
      ZStack {
        subject.getColor().dark
        
        Text(
          (grade.value.rounded() == grade.value)
          ? "\(Int(grade.value))"
            : String(format: "%.2f", grade.value)
        )
          .fontWeight(.heavy)
          .foregroundColor(.white)
          .accessibility(label: Text(NSLocalizedString("Grade Value", comment: "") + ": \(grade.value) " + NSLocalizedString("over 20", comment: "") + "."))
      }
      .frame(width: 65, height: 65)
      .cornerRadius(15)
      .padding(.trailing, 5)
      
      // ----- About
      VStack {
        HStack(alignment: .lastTextBaseline) {
          Text(grade.name)
            .font(.headline)
            .fontWeight(.medium)
            .padding(.bottom, 8)
            .accessibility(label: Text("\(grade.name)."))
          
          Spacer()
        }
        
        HStack {
          Text(
            (grade.coefficient.rounded() == grade.coefficient)
            ? "coeff. \(Int(grade.coefficient))"
            : "coeff \(grade.coefficient.description)"
          )
            .font(.callout)
            .fontWeight(.light)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(subject.getColor().light)
            .cornerRadius(7)
            .accessibility(label: Text(NSLocalizedString("Coefficient", comment: "") + ": \(grade.coefficient)."))
          
          Spacer()
        }
      }
      
      Spacer()
      
      // ----- Link to edit
      Image("Edit")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(subject.getColor().dark)
        .frame(width: 40, height: 40)
        .contrast(0.80)
        .accessibility(hidden: true)
    }
    .padding(.horizontal, 15)
    .accessibilityElement(children: .combine)
    .accessibility(hint: Text("View More About This Grade"))
  }
}

struct GradeListView_Previews: PreviewProvider {
  static var previews: some View {
    GradeListView(
      subject: Subject(name: "Anglais", color: .red, coefficient: 3),
      grade: Grade(name: "Exposé", value: 18, coefficient: 2, date: Date())
    )
  }
}
