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
class Subject: ObservableObject, Identifiable, Codable, Equatable {
  // MARK: Properties
  
  var id: UUID = UUID()
  
  @Published var name: String
  @Published var color: SubjectColor
  @Published var grades: [Grade] = []
  
  @Published var coefficient: Double
  
  @Published var average: String = "0"
  
  // MARK: CodingKeys
  
  enum CodingKeys: CodingKey {
    case id
    case name
    case color
    case grades
    case coefficient
  }
  
  // MARK: Initializer
  
  init(name: String, color: SubjectColor, coefficient: Double) {
    self.name = name
    self.color = color
    
    self.coefficient = coefficient
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try values.decode(UUID.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.color = try values.decode(SubjectColor.self, forKey: .color)
    self.grades = try values.decode([Grade].self, forKey: .grades)
    self.coefficient = try values.decode(Double.self, forKey: .coefficient)
    self.average = averageToString()
  }
  
  // MARK: Function
  
  func addGrade(name: String, value: Double, coefficient: Double, date: Date) {
    grades.append(Grade(name: name, value: value, coefficient: coefficient, date: date))
  }
  
  func getColor() -> (light: Color, dark: Color) {
    switch color {
    case .blue:
      return (.mgBlueLight, .mgBlueDark)
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
  
  func computeAverage() {
    average = averageToString()
  }
  
  func averageToString() -> String {
    if grades.isEmpty {
      return "/"
    }
    
    let avgValue = getAverage()
    return avgValue == avgValue.rounded() ? "\(Int(avgValue))" : String(format: "%.2f", avgValue)
  }
  
  func getAverage() -> Double {
    var average: Double = 0
    var coefficients: Double = 0
    for grade in grades {
      average += grade.value * grade.coefficient
      coefficients += grade.coefficient
    }
    
    return average / coefficients
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.id, forKey: .id)
    try container.encode(self.name, forKey: .name)
    try container.encode(self.color, forKey: .color)
    try container.encode(self.grades, forKey: .grades)
    try container.encode(self.coefficient, forKey: .coefficient)
  }
  
  static func == (lhs: Subject, rhs: Subject) -> Bool {
    lhs.id == rhs.id
  }
}
