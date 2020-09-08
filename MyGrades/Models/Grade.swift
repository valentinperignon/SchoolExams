//
//  Grade.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

/// A  grade
class Grade: ObservableObject, Identifiable, Codable, Equatable {
  // MARK: Properties
  
  var id: UUID = UUID()
  
  @Published var name: String
  
  @Published var value: Double
  @Published var scale: Double
  
  @Published var coefficient: Double
  
  @Published var date: Date
  
  var tag: Int
  
  // MARK: CodingKey
  
  enum CodingKeys: CodingKey {
    case id
    case name
    case value
    case scale
    case coefficient
    case date
    case tag
  }
  
  // MARK: Initializer
  
  init(name: String, value: Double, scale: Double, coefficient: Double, date: Date, tag: Int) {
    self.name = name
    self.value = value
    self.scale = scale
    self.coefficient = coefficient
    self.date = date
    
    self.tag = tag
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try values.decode(UUID.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.value = try values.decode(Double.self, forKey: .value)
    self.scale = try values.decode(Double.self, forKey: .scale)
    self.coefficient = try values.decode(Double.self, forKey: .coefficient)
    self.date = try values.decode(Date.self, forKey: .date)
    self.tag = try values.decode(Int.self, forKey: .tag)
  }
  
  // MARK: Functions
  
  func getGradesOver20() -> Double {
    (self.value * 20.0) / self.scale
  }
  
  static func == (lhs: Grade, rhs: Grade) -> Bool {
    lhs.id == rhs.id
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.id, forKey: .id)
    try container.encode(self.name, forKey: .name)
    try container.encode(self.value, forKey: .value)
    try container.encode(self.scale, forKey: .scale)
    try container.encode(self.coefficient, forKey: .coefficient)
    try container.encode(self.date, forKey: .date)
    try container.encode(self.tag, forKey: .tag)
  }
}
