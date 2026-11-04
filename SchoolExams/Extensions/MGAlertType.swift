//
//  MGAlertType.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 13/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

enum MGAlertType {
  case nameError
  case valueError
  case scaleError
  case removeWarning

  var title: LocalizedStringKey {
    self == .removeWarning ? "Are you sure?" : "Something went wrong"
  }
}
