//
//  RoundedRectangle.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct MGRoundedRectangle: Shape {
  // MARK: Property
  
  let radius: CGFloat
  
  // MARK: Function
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let bl = CGPoint(x: rect.minX, y: rect.maxY)
    let br = CGPoint(x: rect.maxX, y: rect.maxY)
    let tr = CGPoint(x: rect.maxX, y: rect.minY + radius)
    let tr_m = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
    let tl = CGPoint(x: rect.minX + radius, y: rect.minY)
    let tl_m = CGPoint(x: rect.minX + radius, y: rect.minX + radius)
    
    path.move(to: bl)
    path.addLine(to: br)
    path.addLine(to: tr)
    path.addRelativeArc(center: tr_m, radius: radius, startAngle: .degrees(0), delta: .degrees(-90))
    path.addLine(to: tl)
    path.addRelativeArc(center: tl_m, radius: radius, startAngle: .degrees(-90), delta: .degrees(-90))
    path.closeSubpath()
    
    return path
  }
}

struct MGRoundedRectangle_Previews: PreviewProvider {
  static var previews: some View {
    MGRoundedRectangle(radius: 15)
      .stroke(Color.blue)
      .frame(height: 20)
  }
}
