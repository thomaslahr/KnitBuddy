//
//  CustomColorEnum.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

enum CustomColorEnum: String, CaseIterable, ShapeStyle {
	
	case flameOrange = "flameOrange"
	case stormBlue = "stormBlue"
	case oliveGreen = "oliveGreen"
	case woodBrown = "woodBrown"
	case wineBurgundy = "wineBurgundy"
	case grapeIndigo = "grapeIndigo"
	case jungleTeal = "jungleTeal"
	
	var color: Color {
		
		switch self {
		case .flameOrange:
				.flameOrange
		case .jungleTeal:
				.jungleTeal
		case .stormBlue:
				.stormBlue
		case .oliveGreen:
				.oliveGreen
		case .woodBrown:
				.woodBrown
		case .wineBurgundy:
				.wineBurgundy
		case .grapeIndigo:
				.grapeIndigo
		}
	}
}
