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
	@Published var numberOfRowsManual: Int
	@Published var rowsOfRowsManual: Int
	
	// Automatic counter state
	@AppStorage("useAutomaticCounter") var useAutomaticCounter: Bool = false
	
	// Automatic counter state
	@Published var totalNumberOfRowsAutomatic: Int
	
	// Picker states
	@Published var rowCountPicker: Int
	@Published var countByPicker: Int
	
	// Bool for extra button state
	@AppStorage("showExtraButton") var showExtraButton: Bool = false
	
	// Initializer to set up the state and defaults
	init() {
		self.numberOfRowsManual = UserDefaults.standard.integer(forKey: "numberOfRowsManual")
		self.rowsOfRowsManual = UserDefaults.standard.integer(forKey: "rowsOfRowsManual")
		self.totalNumberOfRowsAutomatic = UserDefaults.standard.integer(forKey: "totalNumberOfRows")
		self.rowCountPicker = UserDefaults.standard.integer(forKey: "rowCountPicker") != 0 ? UserDefaults.standard.integer(forKey: "rowCountPicker") : 4
		self.countByPicker = UserDefaults.standard.integer(forKey: "countByPicker") != 0 ? UserDefaults.standard.integer(forKey: "countByPicker") : 1
	}
	
	// Save updated state to UserDefaults
	func saveToUserDefaults() {
		UserDefaults.standard.set(numberOfRowsManual, forKey: "numberOfRowsManual")
		UserDefaults.standard.set(rowsOfRowsManual, forKey: "rowsOfRowsManual")
		UserDefaults.standard.set(totalNumberOfRowsAutomatic, forKey: "totalNumberOfRows")
		UserDefaults.standard.set(rowCountPicker, forKey: "rowCountPicker")
		UserDefaults.standard.set(countByPicker, forKey: "countByPicker")
	}
	
	// Helper property to calculate rows of rows
	var rowsOfRows: Int {
		let denominator = rowCountPicker * countByPicker
		return denominator == 0 ? 0 : totalNumberOfRowsAutomatic / denominator
	}
	
	// Function to reset counters
	func resetCounters() {
		totalNumberOfRowsAutomatic = 0
		numberOfRowsManual = 0
	}
}
