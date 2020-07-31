//
//  File.swift
//  MyGrades
//
//  Created by Valentin Perignon on 26/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

extension FileManager {
  static var userDocumentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
