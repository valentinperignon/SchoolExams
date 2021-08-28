//
//  Average.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 18/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

protocol Average {
  var average: Double { get set }
  var averageDisplay: String { get set }
  
  func computeAverage()
  func averageToString() -> String
}
