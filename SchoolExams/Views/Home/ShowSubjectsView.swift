//
//  ShowSubjectsView.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 28/08/2021.
//  Copyright © 2021 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ShowSubjectsView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  var body: some View {
    ScrollView {
      // ----- Average Grade -----
      
      AverageView(average: allSubjects.averageDisplay)
      
      // ----- Sort tool -----
      
      HStack {
        Text("Sort by")
          .font(.callout)
          .foregroundColor(colorScheme == .light ? .mgPurpleDark : .white)
          .fontWeight(.medium)
          .padding(.trailing, 1)
        
        Picker("Sort by", selection: $allSubjects.sortBy) {
          ForEach(SubjectStore.Order.allCases, id: \.self) { element in
            Text(NSLocalizedString(element.rawValue, comment: ""))
              .accessibility(value: Text(SubjectStore.getAccessibilityOrder(or: element)))
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      .padding(.horizontal, 15)
      .padding(.top, -10)
      
      // ----- Subjects -----
      
      ForEach(allSubjects.subjects) { subject in
        NavigationLink(
          destination: GradesView(subject: subject).environmentObject(self.allSubjects)
        ) {
          SubjectListView(subject: subject)
            .environmentObject(self.allSubjects)
            .contextMenu(
              ContextMenu {
                Button(action: {
                  let feedbackGenerator = UINotificationFeedbackGenerator()
                  feedbackGenerator.notificationOccurred(.success)
                  
                  self.allSubjects.subjects.remove(at:
                    self.allSubjects.subjects.firstIndex(of: subject)!
                  )
                  self.allSubjects.computeAverage()
                }) {
                  Text("Remove")
                  Image(systemName: "trash")
                }
              }
            )
        }
        .accentColor(Color.black)
        .buttonStyle(ButtonListStyle())
        .padding(.horizontal, 10)
        .padding(.bottom, -12)
      }
      
      Spacer(minLength: 25)
    }
  }
}

struct ShowSubjectsView_Previews: PreviewProvider {
  static var previews: some View {
    ShowSubjectsView()
  }
}
