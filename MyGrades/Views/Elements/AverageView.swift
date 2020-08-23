//
//  AverageView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct AverageView: View {
  // MARK: Environment
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  // MARK: Properties
  
  var average: String
  
  let radius: CGFloat = 27
  
  // MARK: Body
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      HStack(alignment: .center) {
        // ----- Icon
        ZStack {
          Rectangle()
            .fill(colorScheme == .light ? Color.white : Color.mgPurpleLight)
          
          Image("Calculator")
            .renderingMode(.template)
            .resizable()
            .foregroundColor(Color.mgPurpleDark)
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
              .foregroundColor(colorScheme == .light ? Color.mgPurpleDark : Color.mgPurpleLight)
              .padding(.bottom, 4)
            Spacer()
          }
          
          // Average grade
          HStack {
            Text("\(average)/20")
              .font(.largeTitle)
              .fontWeight(.light)
              .foregroundColor(colorScheme == .light ? Color.mgPurpleDark : Color.mgPurpleLight)
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
          .fill(colorScheme == .light ? Color.mgPurpleLight : Color.mgPurpleDark_dark)
        
        MGRoundedRectangle(radius: 15)
          .fill(colorScheme == .light ? Color.white : Color.black)
      }
      .frame(height: 20)
    }
    .frame(maxWidth: .infinity)
    .background(colorScheme == .light ? Color.mgPurpleLight : Color.mgPurpleDark_dark)
    .accessibilityElement(children: .combine)
  }
}

struct AverageView_Previews: PreviewProvider {
  static var previews: some View {
    AverageView(average: "14.5")
      .environment(\.colorScheme, .dark)
  }
}
