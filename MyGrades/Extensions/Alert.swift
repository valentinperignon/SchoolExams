//
//  Alert.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 13/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

extension Alert {
  static var mgType: MyGradeType?
  
  enum MyGradeType {
    case nameError
    case valueError
    case removeWarning
  }
}
