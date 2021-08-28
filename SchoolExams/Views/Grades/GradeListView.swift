//
//  GradeListView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 01/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct GradeListView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @ObservedObject var subject: Subject
  @ObservedObject var grade: Grade
  
  var body: some View {
    HStack {
      // ----- Average grade
      ZStack {
        Rectangle()
          .fill(
            colorScheme == .light
            ? (subject.includedInOverall ? subject.getColor().dark : subject.getColor().light)
            : (subject.includedInOverall ? subject.getColorDark().light : subject.getColorDark().dark)
          )
        
        Text(
          (grade.getGradesOver20().rounded() == grade.getGradesOver20())
          ? "\(Int(grade.getGradesOver20()))"
            : String(format: "%.2f", grade.getGradesOver20())
        )
          .fontWeight(.semibold)
          .foregroundColor(
            colorScheme == .light
            ? (subject.includedInOverall ? subject.getColor().light : subject.getColor().dark)
            : (subject.includedInOverall ? subject.getColorDark().dark : subject.getColorDark().light)
          )
          .accessibility(label: Text(NSLocalizedString("Grade Value", comment: "") + ": \(grade.value) " + NSLocalizedString("over 20", comment: "") + "."))
      }
      .clipShape(Circle())
      .overlay(
        Circle()
          .stroke(
            colorScheme == .light
            ? (subject.includedInOverall ? subject.getColor().light : subject.getColor().dark)
            : (subject.includedInOverall ? subject.getColorDark().dark : subject.getColorDark().light),
            lineWidth: 3
          )
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
            .accessibility(label:
              subject.includedInOverall
              ? Text("\(grade.name).")
              : Text("\(grade.name)." + NSLocalizedString("Not in overall average.", comment: ""))
            )
          
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
            .foregroundColor(colorScheme == .light ? subject.getColor().dark : subject.getColorDark().light)
            .background(colorScheme == .light ? subject.getColor().light : subject.getColorDark().dark)
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
        .foregroundColor(colorScheme == .light ? subject.getColor().dark : subject.getColorDark().light)
        .frame(width: 40, height: 40)
        .contrast(0.80)
        .accessibility(hidden: true)
    }
    .padding(.vertical, 5)
    .padding(.horizontal, 5)
    .accessibilityElement(children: .combine)
    .accessibility(hint: Text("View More About This Grade"))
  }
}

struct GradeListView_Previews: PreviewProvider {
  static var previews: some View {
    GradeListView(
      subject: Subject(name: "Anglais", color: .red, coefficient: 3, tag: 0),
      grade: Grade(name: "Exposé", value: 18, scale: 20, coefficient: 2, date: Date(), tag: 0)
    )
  }
}
