//
//  Project.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 08/06/2025.
//

import SwiftUI
import SwiftData

@Model
class Project {
	var name: String
	var id: UUID
	
	@Relationship(deleteRule: .cascade) var counters: [Counter] = []
	var dateCreated: Date = Date.now
	
	@Relationship(deleteRule: .cascade)
	var notes: ProjectNotes
	
	
	var projectColor: String
	init(
		name: String,
		id: UUID = UUID(),
		counters: [Counter],
		dateCreated: Date,
		notes: ProjectNotes = ProjectNotes(details: "", notes: "", yarn: ""),
		projectColor: String = "flameOrange"
	) {
		self.name = name
		self.id = id
		self.counters = counters
		self.dateCreated = dateCreated
		self.notes = notes
		self.projectColor = projectColor
	}
}

extension Project {
	static let sampleProject = Project(
		name: "Sample Project",
		id: UUID(),
		counters: [Counter(name: "New counter")],
		dateCreated: .now,
		projectColor: "flameOrange"
	)
}

extension Project {
	var color: Color {
		guard let projectColor = CounterColorEnum(rawValue: projectColor) else {
			return .flameOrange
		}
		return projectColor.color
	}
}
