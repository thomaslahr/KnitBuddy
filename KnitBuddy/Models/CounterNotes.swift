//
//  CounterNotes.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 30/03/2025.
//

import Foundation
import SwiftData

@Model
class CounterNotes {
	var details: String
	var notes: String
	var yarn: String
	
	init(details: String, notes: String, yarn: String) {
		self.details = details
		self.notes = notes
		self.yarn = yarn
	}
}
