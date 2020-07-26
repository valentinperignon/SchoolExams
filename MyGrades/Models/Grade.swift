//
//  Grade.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

/// A  grade
class Grade: Codable {
  // MARK: Properties
  
  var value: Double
  var coefficient: Double
  
  // MARK: Initializer
  
  init(value: Double, coefficient: Double) {
    self.value = value
    self.coefficient = coefficient
  }
}
