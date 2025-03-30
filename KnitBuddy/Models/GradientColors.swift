//
//  GradientColors.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 25/12/2024.
//

import SwiftUI

enum GradientColors {
	static let primaryAppColor = LinearGradient(colors: [.flameOrange, .mangoYellow], startPoint: .leading, endPoint: .trailing)
	
	case custom(Color)
	
	var gradient: LinearGradient {
		switch self {
		case .custom(let userColor):
			return LinearGradient(colors: [userColor.opacity(0.6), userColor.opacity(0.9)], startPoint: .leading, endPoint: .trailing)
		}
	}
}
