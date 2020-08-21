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
class Subject: Average, ObservableObject, Identifiable, Codable, Equatable {
  // MARK: Properties
  
  var id: UUID
  
  @Published var name: String
  @Published var color: CustomColor
  @Published var grades: [Grade]
  @Published var coefficient: Double
  @Published var average: Double
  @Published var averageDisplay: String
  @Published var sortBy: Subject.Order {
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
    
    case tag
  }
  
  // MARK: Initializer
  
  init(name: String, color: CustomColor, coefficient: Double, tag: Int) {
    self.id = UUID()
    
    self.name = name
    self.color = color
    self.grades = []
    self.coefficient = coefficient
    self.average = 0
    self.averageDisplay = "0"
    self.sortBy = .custom
    
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
    self.sortBy = .custom
    
    self.tag = try values.decode(Int.self, forKey: .tag)
    
    computeAverage()
  }
  
  // MARK: Function
  
  /// Add a new grade
  func addGrade(name: String, value: Double, coefficient: Double, date: Date) {
    grades.append(Grade(name: name, value: value, coefficient: coefficient, date: date, tag: grades.count))
  }
  
  /// Get dark and light colors
  func getColor() -> (light: Color, dark: Color) {
    switch color {
    case .blue:
      return (.mgBlueLight, .mgBlueDark)
    case .orange:
      return (.mgOrangeLight, .mgOrangeDark)
    case .red:
      return (.mgRedLight, .mgRedDark)
    case .green:
      return (.mgGreenLight, .mgGreenDark)
    default:
      return (.mgPurpleLight, .mgPurpleDark)
    }
  }
  
  /// Compute subject average
  func computeAverage() {
   var averageValue: Double = 0
    var coefficients: Double = 0
    for grade in grades {
      averageValue += grade.value * grade.coefficient
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
      case .custom:
        return first.tag < second.tag
      case .lowToHigh:
        return first.value < second.value
      case .highToLow:
        return first.value > second.value
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
    
    try container.encode(self.tag, forKey: .tag)
  }
  
  /// Equals
  static func == (lhs: Subject, rhs: Subject) -> Bool {
    lhs.id == rhs.id
  }
}
