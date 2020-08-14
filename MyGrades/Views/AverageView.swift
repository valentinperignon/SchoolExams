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
        .resizable()
        .frame(width: 65, height: 65)
      
      // ----- Text
      VStack {
        // Title
        HStack {
          Text("Average")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.bottom, 5)
          Spacer()
        }
        
        // Average grade
        HStack {
          Text("\(average)/20")
            .font(.largeTitle)
            .fontWeight(.light)
            .foregroundColor(.white)
          Spacer()
        }
      }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity)
    .background(Color.mgPurpleDark)
    .cornerRadius(20)
    .padding(.horizontal, 15)
  }
}

struct AverageView_Previews: PreviewProvider {
  static var previews: some View {
    AverageView(average: "14.5")
  }
}
