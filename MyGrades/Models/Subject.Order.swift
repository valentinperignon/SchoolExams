//
//  Subject.Order.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 18/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

extension Subject {
  enum Order: String, CaseIterable, Codable {
    case defaultOrder = "default"
    case lowToHigh = "- to +"
    case highToLow = "+ to -"
    case date = "date"
  }
  
  static func getAccessibilityOrder(or: Subject.Order) -> String {
    let value: String
    switch or {
    case .defaultOrder:
      value = "Default order."
    case .lowToHigh:
      value = "Ascending order."
    case .highToLow:
      value = "descending order."
    case .date:
      value = "From lowest to newest."
    }
    
    return value
  }}
