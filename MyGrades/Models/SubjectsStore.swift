//
//  SubjectsStore.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

/// All the subjects
class SubjectStore: ObservableObject {
  // MARK: Properties
  
  let dataURL = URL(fileURLWithPath: "SubjectsStore", relativeTo: FileManager.userDocumentsURL).appendingPathExtension("json")
  @Published var subjects: [Subject] = [] {
    didSet {
      saveJSON()
    }
  }
  
  // MARK: Initializer
  
  init() {
    loadJSON()
  }
  
  // MARK: Functions
  
  /// Load all subjects from a JSON file
  func loadJSON() {
    // Check  if file exists
    guard FileManager.default.fileExists(atPath: dataURL.path) else {
      return
    }
    
    // Get decoder
    let decoder = JSONDecoder()
    
    // Load JSON
    do {
      let data = try Data(contentsOf: dataURL)
      subjects = try decoder.decode([Subject].self, from: data)
    } catch let error {
      print(error)
    }
  }
  
  /// Save all subjects to a JSON file
  func saveJSON() {
    // Get encoder
    let encoder = JSONEncoder()
    
    // Save JSON
    do {
      let data = try encoder.encode(subjects)
      try data.write(to: dataURL)
    } catch let error {
      print(error)
    }
  }
}
