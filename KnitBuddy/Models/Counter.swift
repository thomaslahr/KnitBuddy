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
	
	var notes = ""
	var dateCreated: Date
	
	init(name: String, counterColor: String = "flameOrange", rows: Int = 0, dateCreated: Date = .now) {
		self.name = name
		self.counterColor = counterColor
		self.rows = rows
		self.dateCreated = dateCreated
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
