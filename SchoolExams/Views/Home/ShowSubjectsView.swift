//
//  ShowSubjectsView.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 28/08/2021.
//  Copyright © 2021 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct SortTools: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @EnvironmentObject var allSubjects: SubjectStore

    var body: some View {
        HStack {
          Text("Sort by")
            .font(.callout)
            .foregroundStyle(colorScheme == .light ? Color.mgPurpleDark : .white)
            .fontWeight(.medium)
            .padding(.trailing, 1)

          Picker("Sort by", selection: $allSubjects.sortBy) {
            ForEach(SubjectStore.Order.allCases, id: \.self) { element in
              Text(NSLocalizedString(element.rawValue, comment: ""))
                .accessibilityValue(Text(SubjectStore.getAccessibilityOrder(or: element)))
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.horizontal, 15)
        .padding(.top, -10)
    }
}

struct ShowSubjectsView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  var body: some View {
    ScrollView {
      AverageView(average: allSubjects.averageDisplay)
      
      SortTools()
      
      // ----- Subjects -----
      
      ForEach(allSubjects.subjects) { subject in
        NavigationLink {
          GradesView(subject: subject)
        } label: {
          SubjectListView(subject: subject)
            .contextMenu {
              Button(action: {
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.notificationOccurred(.success)
                
                self.allSubjects.subjects.remove(at:
                  self.allSubjects.subjects.firstIndex(of: subject)!
                )
                self.allSubjects.computeAverage()
              }) {
                Label("Remove", systemImage: "trash")
              }
            }
        }
        .tint(Color.black)
        .buttonStyle(ButtonListStyle())
        .padding(.horizontal, 10)
        .padding(.bottom, -12)
      }
      
      Spacer(minLength: 25)
    }
  }
}

#Preview {
  ShowSubjectsView()
    .environmentObject(SubjectStore())
}
