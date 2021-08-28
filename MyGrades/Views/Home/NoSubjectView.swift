//
//  NoSubjectView.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 28/08/2021.
//  Copyright © 2021 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct NoSubjectView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Binding var showSheet: Bool
  
  var body: some View {
    VStack {
      Spacer()
      
      Image("NothingToPrint")
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .padding(.horizontal, 40)
        .foregroundColor(colorScheme == .light ? .mgPurpleLight : .appleDarkGray5)
        .accessibility(hidden: true)
      
      VStack {
        Text("No Subject")
          .font(.title)
          .fontWeight(.bold)
        Text("You need to add at least one subject")
          .foregroundColor(.mgPurpleDark)
          .multilineTextAlignment(.center)
      }
      .accessibilityElement(children: .combine)
      
      Spacer()
      
      ButtonFullWidth(type: .primary, title: "New Subject", iconSysName: "plus") {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        
        showSheet.toggle()
      }
      .padding(.bottom, 30)
    }
  }
}

struct NoSubjectView_Previews: PreviewProvider {
  static var previews: some View {
    NoSubjectView(showSheet: .constant(false))
  }
}
