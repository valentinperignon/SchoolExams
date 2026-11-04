//
//  SchoolExamsApp.swift
//  MyGrades
//
//  Created by Valentin Perignon on 25/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

@main
struct SchoolExamsApp: App {
  @StateObject private var allSubjects = SubjectStore()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(allSubjects)
    }
  }
}
