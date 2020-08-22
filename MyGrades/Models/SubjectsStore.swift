//
//  SubjectsStore.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

/// All the subjects
class SubjectStore: Average, ObservableObject {
  // MARK: Properties
  
  let dataURL = URL(fileURLWithPath: "SubjectsStore", relativeTo: FileManager.userDocumentsURL).appendingPathExtension("json")
  
  @Published var subjects: [Subject] {
    didSet {
      saveJSON()
    }
  }
  
  @Published var average: Double
  @Published var averageDisplay: String
  
  @Published var sortBy: SubjectStore.Order {
    didSet {
      sortSubjects()
      saveJSON()
    }
  }
  
  // MARK: Initializer
  
  init() {
    subjects = []
    average = 0
    averageDisplay = "0"
    sortBy = .defaultOrder
    
    loadJSON()
    computeAverage()
  }
  
  // MARK: Functions
  
  /// Compute overall average
  func computeAverage() {
    var averageValue: Double = 0
    var coefficients: Double = 0
    
    for subject in subjects where !subject.grades.isEmpty {
      averageValue += subject.average * subject.coefficient
      coefficients += subject.coefficient
    }
    
    if coefficients == 0 {
      average = 0
      averageDisplay = "0"
      return
    }
    average = averageValue / coefficients
    averageDisplay = averageToString()
  }
  
  /// Transform the average into a string
  func averageToString() -> String {
    if average.rounded() == average {
      return "\(Int(average))"
    }
    return String(format: "%.2f", average)
  }
  
  /// Sort subjects according to user choice
  func sortSubjects() {
    subjects.sort { first, second in
      switch self.sortBy {
      case .defaultOrder:
        return first.tag < second.tag
      case .lowToHigh:
        return first.average < second.average
      case .highToLow:
        return first.average > second.average
      }
    }
  }
  
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
