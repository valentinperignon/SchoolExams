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
  
  let radius: CGFloat = 27
  
  // MARK: Body
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      HStack(alignment: .center) {
        // ----- Icon
        ZStack {
          Color.white
          
          Image("Calculator")
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.mgPurpleDark)
            .frame(width: 50, height: 50)
            .accessibility(hidden: true)
        }
        .frame(width: 75, height: 75)
        .clipShape(Circle())
        .padding(.trailing, 5)
        
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
      .padding(.horizontal, 15)
      .padding(.top, 5)
      .padding(.bottom, 10)
      
      ZStack {
        Rectangle()
          .fill(Color.mgPurpleLight)
        
        MGRoundedRectangle(radius: 15)
          .fill(Color.white)
      }
      .frame(height: 20)
    }
    .frame(maxWidth: .infinity)
    .background(Color.mgPurpleLight)
    .accessibilityElement(children: .combine)
  }
}

struct AverageView_Previews: PreviewProvider {
  static var previews: some View {
    AverageView(average: "14.5")
  }
}
