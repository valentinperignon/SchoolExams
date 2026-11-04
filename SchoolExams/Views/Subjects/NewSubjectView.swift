//
//  NewSubjectView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 30/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct NewSubjectView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var allSubjects: SubjectStore

    @State private var name: String = ""
    @State private var coefficient: Double = 1
    @State private var accentColor: Subject.CustomColor = .purple

    @State private var showAlert = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                // ----- Title
                SheetHeaderView(title: "New Subject", subtitle: "Add a new subject to your list")

                // ----- Form

                VStack {
                    // Name
                    FormTextFieldView(keyboardType: .default, title: "Subject name", textValue: $name)
                        .padding(.bottom, 10)

                    // Coefficient
                    FormStepperView(title: "Coefficient", value: $coefficient, range: 0.5 ... 20, step: 0.5)
                        .padding(.bottom, 10)

                    // Accent color
                    FormColorPickerView(title: "Accent color", value: $accentColor)
                        .padding(.bottom, 12)

                    // Button
                    ButtonFullWidth(type: .primary, title: "Add the Subject", iconSysName: "checkmark") {
                        let feedbackGenerator = UINotificationFeedbackGenerator()
                        feedbackGenerator.prepare()

                        guard !self.name.isEmpty else {
                            self.showAlert.toggle()
                            feedbackGenerator.notificationOccurred(.error)
                            return
                        }

                        feedbackGenerator.notificationOccurred(.success)

                        self.allSubjects.subjects.append(
                            Subject(name: self.name, color: self.accentColor, coefficient: self.coefficient, tag: self.allSubjects.subjects.count)
                        )
                        self.dismiss()
                    }
                }

                Spacer()
            }
            .alert("Something went wrong", isPresented: $showAlert) {
                Button("OK") {}
            } message: {
                Text("The name of the subject can't be empty.")
            }
        }
    }
}

#Preview {
    NewSubjectView()
        .environmentObject(SubjectStore())
}
