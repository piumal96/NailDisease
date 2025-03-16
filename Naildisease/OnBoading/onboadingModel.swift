//
//  Untitled.swift
//  Naildisease
//
//  Created by Piumal Kumara on 2025-03-16.
//

import Foundation
import SwiftUI

struct OnBording: Identifiable, Equatable {
  var id = UUID()
  var title: String
  var headline: String
  var image: String
  var gradientColors: [Color]
  var tag: Int
}
