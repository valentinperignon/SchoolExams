//
//  Subject.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI
import Foundation

/// A school subject
class Subject: Average, ObservableObject, Identifiable, Codable {
  // MARK: Properties
  
  var id = UUID()
  
  @Published var name: String
  
  @Published var color: CustomColor
  
  @Published var grades = [Grade]()
  @Published var coefficient: Double
  
  @Published var average = 0.0
  @Published var averageDisplay = "0"
  @Published var includedInOverall = true
  
  @Published var sortBy: Subject.Order = .defaultOrder {
    didSet {
      sortGrades()
    }
  }
  
  var tag: Int
  
  // MARK: CodingKeys
  
  enum CodingKeys: CodingKey {
    case id
    
    case name
    case color
    case grades
    case coefficient
    case includedInOverall
    
    case tag
  }
  
  // MARK: Initializer
  
  init(name: String, color: CustomColor, coefficient: Double, tag: Int) {
    self.name = name
    self.color = color
    self.coefficient = coefficient
    self.tag = tag
    
    computeAverage()
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try values.decode(UUID.self, forKey: .id)
    
    self.name = try values.decode(String.self, forKey: .name)
    self.color = try values.decode(CustomColor.self, forKey: .color)
    self.grades = try values.decode([Grade].self, forKey: .grades)
    self.coefficient = try values.decode(Double.self, forKey: .coefficient)
    self.average = 0
    self.averageDisplay = "0"
    self.includedInOverall = try values.decode(Bool.self, forKey: .includedInOverall)
    self.sortBy = .defaultOrder
    
    self.tag = try values.decode(Int.self, forKey: .tag)
    
    computeAverage()
  }
  
  // MARK: Function
  
  /// Add a new grade
  func addGrade(name: String, value: Double, scale: Double, coefficient: Double, date: Date) {
    grades.append(Grade(name: name, value: value, scale: scale, coefficient: coefficient, date: date, tag: grades.count))
  }
  
  /// Get dark and light colors
  static func getColor(subjectColor: Subject.CustomColor) -> (light: Color, dark: Color) {
    switch subjectColor {
    case .blue:
      return (.mgBlueLight, .mgBlueDark)
    case .gray:
      return (.mgGrayLight, .mgGrayDark)
    case .green:
      return (.mgGreenLight, .mgGreenDark)
    case .orange:
      return (.mgOrangeLight, .mgOrangeDark)
    case .red:
      return (.mgRedLight, .mgRedDark)
    case .yellow:
      return (.mgYellowLight, .mgYellowDark)
    default:
      return (.mgPurpleLight, .mgPurpleDark)
    }
  }
  
  static func getColorDark(subjectColor: Subject.CustomColor) -> (light: Color, dark: Color) {
    switch subjectColor {
    case .blue:
      return (.mgBlueLight_dark, .mgBlueDark_dark)
    case .gray:
      return (.mgGrayLight_dark, .mgGrayDark_dark)
    case .green:
      return (.mgGreenLight_dark, .mgGreenDark_dark)
    case .orange:
      return (.mgOrangeLight_dark, .mgOrangeDark_dark)
    case .red:
      return (.mgRedLight_dark, .mgRedDark_dark)
    case .yellow:
      return (.mgYellowLight_dark, .mgYellowDark_dark)
    default:
      return (.mgPurpleLight_dark, .mgPurpleDark_dark)
    }
  }
  
  func getColor() -> (light: Color, dark: Color) {
    return Subject.getColor(subjectColor: self.color)
  }
  
  func getColorDark() -> (light: Color, dark: Color) {
    return Subject.getColorDark(subjectColor: self.color)
  }
  
  /// Compute subject average
  func computeAverage() {
    var averageValue = 0.0
    var coefficients = 0.0
    for grade in grades {
      averageValue += grade.getGradesOver20() * grade.coefficient
      coefficients += grade.coefficient
    }
    
    average = averageValue / coefficients
    averageDisplay = averageToString()
  }
  
  /// Transform the average to a string
  func averageToString() -> String {
    if grades.isEmpty {
      return "/"
    }
    
    return average == average.rounded() ? "\(Int(average))" : String(format: "%.2f", average)
  }
  
  /// Sort grades according to user choice
  func sortGrades() {
    grades.sort { first, second in
      switch self.sortBy {
      case .defaultOrder:
        return first.tag < second.tag
      case .lowToHigh:
        return first.getGradesOver20() < second.getGradesOver20()
      case .highToLow:
        return first.getGradesOver20() > second.getGradesOver20()
      case .date:
        return first.date < second.date
      }
    }
  }
  
  /// Encode subject
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.id, forKey: .id)
    
    try container.encode(self.name, forKey: .name)
    try container.encode(self.color, forKey: .color)
    try container.encode(self.grades, forKey: .grades)
    try container.encode(self.coefficient, forKey: .coefficient)
    try container.encode(self.includedInOverall, forKey: .includedInOverall)
    
    try container.encode(self.tag, forKey: .tag)
  }
}

// MARK: - Equatable

extension Subject: Equatable {
  static func == (lhs: Subject, rhs: Subject) -> Bool {
    lhs.id == rhs.id
  }
}
