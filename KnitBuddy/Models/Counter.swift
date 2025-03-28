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
	var rows = 0
	var counterColor: String
	
	init(name: String, counterColor: String = "flameOrange") {
		self.name = name
		self.counterColor = counterColor
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
