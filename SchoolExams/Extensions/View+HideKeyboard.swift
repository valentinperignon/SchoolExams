//
//  View+HideKeyboard.swift
//  SchoolExams
//
//  Created by Valentin Perignon on 13/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
