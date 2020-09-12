
//
//  SubjectStore.Order.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 18/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

extension SubjectStore {
  enum Order: String, CaseIterable, Codable {
    case defaultOrder = "default"
    case lowToHigh = "- to +"
    case highToLow = "+ to -"
  }
  
  static func getAccessibilityOrder(or: SubjectStore.Order) -> String {
    let value: String
    switch or {
    case .defaultOrder:
      value = "Default order."
    case .lowToHigh:
      value = "Ascending order."
    case .highToLow:
      value = "Descending order."
    }
    
    return value
  }
}
