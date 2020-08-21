//
//  AverageView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct AverageView: View {
  // MARK: Properties
  
  var average: String
  
  // MARK: Body
  
  var body: some View {
    HStack(alignment: .center) {
      // ----- Icon
      Image("Calculator")
        .renderingMode(.template)
        .resizable()
        .foregroundColor(.mgPurpleDark)
        .frame(width: 60, height: 60)
        .accessibility(hidden: true)
      
      // ----- Text
      VStack {
        // Title
        HStack {
          Text("Average")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.mgPurpleDark)
            .padding(.bottom, 4)
          Spacer()
        }
        
        // Average grade
        HStack {
          Text("\(average)/20")
            .font(.largeTitle)
            .fontWeight(.light)
            .foregroundColor(.mgPurpleDark)
            .accessibility(label: Text("\(average) " + NSLocalizedString("over 20", comment: "")))
          Spacer()
        }
      }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 14)
    .frame(maxWidth: .infinity)
    .background(Color.mgPurpleLight)
    .cornerRadius(15)
    .overlay(
      RoundedRectangle(cornerRadius: 15)
        .stroke(Color.mgPurpleDark, lineWidth: 1)
    )
    .accessibilityElement(children: .combine)
    .padding(.horizontal, 15)
  }
}

struct AverageView_Previews: PreviewProvider {
  static var previews: some View {
    AverageView(average: "14.5")
  }
}
