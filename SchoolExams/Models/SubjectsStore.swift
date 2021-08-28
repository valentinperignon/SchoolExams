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
  let dataURL = URL(fileURLWithPath: "SubjectsStore", relativeTo: FileManager.userDocumentsURL).appendingPathExtension("json")
  
  @Published var subjects = [Subject]() {
    didSet {
      saveJSON()
    }
  }
  
  @Published var average = 0.0
  @Published var averageDisplay = "0"
  
  @Published var sortBy: SubjectStore.Order = .defaultOrder {
    didSet {
      sortSubjects()
      saveJSON()
    }
  }
  
  init() {
    loadJSON()
    computeAverage()
  }
  
  /// Compute overall average
  func computeAverage() {
    var averageValue = 0.0
    var coefficients = 0.0
    
    for subject in subjects where !subject.grades.isEmpty && subject.includedInOverall {
      averageValue += subject.average * subject.coefficient
      coefficients += subject.coefficient
    }
    
    if coefficients == 0 {
      average = 0
      averageDisplay = "-"
    } else {
      average = averageValue / coefficients
      averageDisplay = averageToString()
    }
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
      switch sortBy {
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
    guard FileManager.default.fileExists(atPath: dataURL.path) else { return }
    
    let decoder = JSONDecoder()
    do {
      let data = try Data(contentsOf: dataURL)
      subjects = try decoder.decode([Subject].self, from: data)
    } catch {
      print("Can't load JSON. \(error)")
    }
  }
  
  /// Save all subjects to a JSON file
  func saveJSON() {
    let encoder = JSONEncoder()
    
    do {
      let data = try encoder.encode(subjects)
      try data.write(to: dataURL)
    } catch {
      print("Can't write JSON. \(error)")
    }
  }
}
