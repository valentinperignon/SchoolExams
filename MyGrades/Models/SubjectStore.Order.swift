
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
}
