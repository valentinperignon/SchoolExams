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
  
  var average: Double
  
  // MARK: Body
  
  var body: some View {
    HStack(alignment: .center) {
      // ----- Icon
      Image("Calculator")
        .resizable()
        .frame(width: 84, height: 84)
      
      // ----- Text
      VStack {
        // Title
        HStack {
          Text("Average")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.bottom, 15)
          Spacer()
        }
        
        // Average grade
        HStack {
          Text("\(average.description)/20")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
          Spacer()
        }
      }
    }
    .padding(.horizontal, 15)
    .frame(maxWidth: .infinity)
    .padding(.vertical, 20)
    .background(Color.mgPurpleDark)
    .cornerRadius(20)
    .padding(.horizontal, 15)
  }
}

struct AverageView_Previews: PreviewProvider {
  static var previews: some View {
    AverageView(average: 14.5)
  }
}
