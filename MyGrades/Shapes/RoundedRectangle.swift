//
//  RoundedRectangle.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct RoundedRectangle: Shape {
  // MARK: Property
  
  let radius: CGFloat
  
  // MARK: Function
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let tl = CGPoint(x: rect.minX, y: rect.minY)
    let tr = CGPoint(x: rect.maxX, y: rect.minY)
    let br_a = CGPoint(x: rect.maxX, y: rect.maxY - radius)
    let br_b = CGPoint(x: rect.maxX - radius, y: rect.maxY - radius)
    let bl_a = CGPoint(x: rect.minX + radius, y: rect.maxY)
    let bl_b = CGPoint(x: rect.minX + radius, y: rect.maxY - radius)
    
    path.move(to: tl)
    path.addLine(to: tr)
    path.addLine(to: br_a)
    path.addRelativeArc(center: br_b, radius: radius, startAngle: .degrees(0), delta: .degrees(90))
    path.addLine(to: bl_a)
    path.addRelativeArc(center: bl_b, radius: radius, startAngle: .degrees(90), delta: .degrees(90))
    
    return path
  }
}
