//
//  Counter.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import Foundation
import SwiftData

@Model
class Counter {
	var name: String
	var rows = 0
	
	init(name: String) {
		self.name = name
	}
}
