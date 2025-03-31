//
//  MainViewModel.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 27/03/2025.
//

import SwiftUI
import SwiftData

// ViewModel should manage your state for rows and UserDefaults
class MainViewModel: ObservableObject {
	// Manual counter state
	@Published var numberOfStitchesManual: Int
	@Published var rowsOfStitchesManual: Int
	
	// Automatic counter state
	@AppStorage("useAutomaticCounter") var useAutomaticCounter: Bool = false
	
	// Automatic counter state
	@Published var totalNumberOfStitchesAutomatic: Int
	
	// Picker states
	@Published var rowCountPicker: Int
	@Published var countByPicker: Int
	
	// Bool for extra button state
	@AppStorage("showExtraButton") var showExtraButton: Bool = false
	
	// Initializer to set up the state and defaults
	init() {
		self.numberOfStitchesManual = UserDefaults.standard.integer(forKey: "numberOfRowsManual")
		self.rowsOfStitchesManual = UserDefaults.standard.integer(forKey: "rowsOfRowsManual")
		self.totalNumberOfStitchesAutomatic = UserDefaults.standard.integer(forKey: "totalNumberOfRows")
		self.rowCountPicker = UserDefaults.standard.integer(forKey: "rowCountPicker") != 0 ? UserDefaults.standard.integer(forKey: "rowCountPicker") : 4
		self.countByPicker = UserDefaults.standard.integer(forKey: "countByPicker") != 0 ? UserDefaults.standard.integer(forKey: "countByPicker") : 1
	}
	
	// Save updated state to UserDefaults
	func saveToUserDefaults() {
		UserDefaults.standard.set(numberOfStitchesManual, forKey: "numberOfRowsManual")
		UserDefaults.standard.set(rowsOfStitchesManual, forKey: "rowsOfRowsManual")
		UserDefaults.standard.set(totalNumberOfStitchesAutomatic, forKey: "totalNumberOfRows")
		UserDefaults.standard.set(rowCountPicker, forKey: "rowCountPicker")
		UserDefaults.standard.set(countByPicker, forKey: "countByPicker")
	}
	
	// Helper property to calculate rows of rows
	var rowsOfStiches: Int {
		let denominator = rowCountPicker * countByPicker
		return denominator == 0 ? 0 : totalNumberOfStitchesAutomatic / denominator
	}
	
	// Function to reset counters
	func resetCounters() {
		totalNumberOfStitchesAutomatic = 0
		numberOfStitchesManual = 0
	}
}
