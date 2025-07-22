//
//  ButtonSymbol.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 14/06/2025.
//

import Foundation

enum ButtonSymbol {
	case edit
	case save
	case tooLongOrTooShort
	
	var currentSymbol: String {
		switch self {
		case .edit:
			"pencil.circle"
		case .save:
			"checkmark.circle.fill"
		case .tooLongOrTooShort:
			"x.circle"
		}
	}
}
