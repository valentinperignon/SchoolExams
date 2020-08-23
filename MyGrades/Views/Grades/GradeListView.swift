//
//  GradeListView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct GradeListView: View {
  // MARK: Environment
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
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
          .fontWeight(.semibold)
          .foregroundColor(subject.getColor().light)
          .accessibility(label: Text(NSLocalizedString("Grade Value", comment: "") + ": \(grade.value) " + NSLocalizedString("over 20", comment: "") + "."))
      }
      .clipShape(Circle())
      .overlay(
        Circle()
          .stroke(subject.getColor().light, lineWidth: 3)
      )
      .frame(width: 65, height: 65)
      .padding(.trailing, 5)
      
      // ----- About
      VStack {
        HStack(alignment: .lastTextBaseline) {
          Text(grade.name)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.primary)
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
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .foregroundColor(subject.getColor().dark)
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
        .foregroundColor(colorScheme == .light ? subject.getColor().dark : subject.getColor().light)
        .frame(width: 40, height: 40)
        .contrast(0.80)
        .accessibility(hidden: true)
    }
    .accessibilityElement(children: .combine)
    .accessibility(hint: Text("View More About This Grade"))
  }
}

struct GradeListView_Previews: PreviewProvider {
  static var previews: some View {
    GradeListView(
      subject: Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0),
      grade: Grade(name: "Exposé", value: 18, coefficient: 2, date: Date(), tag: 0)
    )
  }
}
