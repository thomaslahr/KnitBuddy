//
//  Counter.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI
import SwiftData

@Model
class Counter {
	var name: String
	var rows: Int
	var counterColor: String
	var isLocked = false
	
	init(name: String, counterColor: String = "flameOrange", rows: Int = 0) {
		self.name = name
		self.counterColor = counterColor
		self.rows = rows
	}
}

extension Counter {
	var color: Color {
		guard let counterColor = CounterColorEnum(rawValue: counterColor) else {
			return .flameOrange
		}
		return counterColor.color
	}
}
