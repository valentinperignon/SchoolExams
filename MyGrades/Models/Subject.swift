//
//  Subject.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

/// A school subject
class Subject: Codable {
  // MARK: Properties
  
  var name: String
  var color: SubjectColor
  var grades: [Grade] = []
  
  var coefficient: Double
  
  // MARK: Initializer
  
  init(name: String, color: SubjectColor, coefficient: Double) {
    self.name = name
    self.color = color
    
    self.coefficient = coefficient
  }
}
