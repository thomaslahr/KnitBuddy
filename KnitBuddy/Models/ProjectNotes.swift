//
//  ProjectNotes.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 30/03/2025.
//

import Foundation
import SwiftData

@Model
class ProjectNotes {
	var details: String
	var notes: String
	
	var yarnInfo: String
	var dyeLot: String
	var color: String
	
	var needleType: String
	var needleThickness: String
	
	init(
		details: String = "",
		notes: String = "",
		yarnInfo: String = "",
		dyeLot: String = "",
		color: String = "",
		needleType: String = "",
		needleThickness: String = ""
	) {
		self.details = details
		self.notes = notes
		self.yarnInfo = yarnInfo
		self.dyeLot = dyeLot
		self.color = color
		self.needleType = needleType
		self.needleThickness = needleThickness
	}
}
