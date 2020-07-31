//
//  SubjectStoreDemo.swift
//  MyGrades
//
//  Created by Valentin Perignon on 31/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import Foundation

extension SubjectStore {
  static func getDemoData() -> SubjectStore {
    let subjectStore = SubjectStore()
    
    subjectStore.subjects.append(
      Subject(name: "Langages du Web", color: .purple, coefficient: 6)
    )
    subjectStore.subjects.append(
      Subject(name: "Recherche doc", color: .orange, coefficient: 3)
    )
    
    return subjectStore
  }
}
