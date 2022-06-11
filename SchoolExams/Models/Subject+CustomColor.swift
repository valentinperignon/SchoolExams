//
//  SubjectColor.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

extension Subject {
  /// All possible colors for a subject
  enum CustomColor: String, CaseIterable, Codable {
    case blue
    case gray
    case green
    case orange
    case purple
    case red
    case yellow
  }
}
