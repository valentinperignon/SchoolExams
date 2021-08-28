//
//  SubjectListView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct SubjectListView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @ObservedObject var subject: Subject
  
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
        
        Text(subject.averageDisplay)
          .fontWeight(.semibold)
          .foregroundColor(
            colorScheme == .light
            ? (subject.includedInOverall ? subject.getColor().light : subject.getColor().dark)
            : (subject.includedInOverall ? subject.getColorDark().dark : subject.getColorDark().light)
          )
          .accessibility(label:
            subject.averageDisplay == "/"
              ? Text("No Grade In This Subject.")
              : Text(NSLocalizedString("Subject Average", comment: "") + ": \(subject.averageDisplay) " + NSLocalizedString("over 20", comment: "") + ".")
          )
      }
      .clipShape(Circle())
      .overlay(
        Circle()
          .stroke(
            colorScheme == .light
            ? (subject.includedInOverall ? subject.getColor().light : subject.getColor().dark)
            : (subject.includedInOverall ? subject.getColorDark().dark : subject.getColorDark().light),
            lineWidth: 3)
      )
      .frame(width: 65, height: 65)
      .padding(.trailing, 5)
      
      // ----- About
      VStack {
        HStack {
          if subject.average < 10.0 {
            Image(systemName: "exclamationmark.circle")
              .font(.headline)
              .foregroundColor(.mgOrangeDark)
              .accessibility(hidden: true)
          }
          Text(subject.name)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(
              subject.average < 10.0 ? .mgOrangeDark : .primary
            )
            .accessibility(label:
              subject.includedInOverall
              ? Text("\(subject.name).")
              : Text("\(subject.name)." + NSLocalizedString("Not in overall average.", comment: ""))
            )
            
          Spacer()
        }
        .padding(.bottom, subject.average < 10.0 ? 0 : 6)
        
        HStack {
          Text(
            (subject.coefficient.rounded() == subject.coefficient)
              ? "coeff. \(Int(subject.coefficient))"
              : String(format: "coeff: %.2f", subject.coefficient)
          )
            .font(.callout)
            .fontWeight(.light)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(colorScheme == .light ? subject.getColor().light : subject.getColorDark().dark)
            .foregroundColor(colorScheme == .light ? subject.getColor().dark : subject.getColorDark().light)
            .cornerRadius(7)
            .accessibility(label: Text(NSLocalizedString("Coefficient", comment: "") + ":  \(subject.coefficient)."))
          Spacer()
        }
      }
      
      Spacer()
      
      // ----- Link to edit
      Image("ArrowRight")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(colorScheme == .light ? subject.getColor().dark : subject.getColorDark().light)
        .frame(width: 37, height: 37)
        .contrast(0.95)
        .brightness(0.01)
        .accessibility(hidden: true)
    }
    .padding(.vertical, 5)
    .padding(.horizontal, 5)
    .accessibilityElement(children: .combine)
    .accessibility(hint: Text("View More About This Subject"))
  }
}

struct SubjectListView_Previews: PreviewProvider {
  static var previews: some View {
    let subject = Subject(name: "Langages du Web", color: .purple, coefficient: 6, tag: 0)
    subject.addGrade(name: "Test", value: 15.5, scale: 20, coefficient: 1, date: Date())
    subject.computeAverage()
    
    return SubjectListView(subject:
      subject
    )
  }
}
