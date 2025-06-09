//
//  RowNumber.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 31/12/2024.
//

import Foundation
import SwiftData

@Model
class RowNumber {
	var numberOfRows: Int
	var rowsOfRowsManual: Int
	
	init(numberOfRows: Int = 0, rowsOfRowsManual: Int = 0) {
		self.numberOfRows = numberOfRows
		self.rowsOfRowsManual = rowsOfRowsManual
	}
}
