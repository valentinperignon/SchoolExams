//
//  ContentView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 25/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  // MARK: Body
  
  var body: some View {
    ZStack {
      Color(red: 229/254, green: 229/254, blue: 234/254)
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Image("NothingToPrint")
        Text("NOTHING TO PRINT")
          .font(.system(.callout, design: .rounded))
          .bold()
          .foregroundColor(.myGradesPurpleLight)
          .padding(.top)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

