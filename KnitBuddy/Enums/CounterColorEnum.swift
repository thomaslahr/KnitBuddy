//
//  CounterColorEnum.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

enum CounterColorEnum: String, CaseIterable {
	
	case flameOrange = "flameOrange"
	case jungleTeal = "jungleTeal"
	case stormBlue = "stromBlue"
	case oliveGreen = "oliveGreen"
	case woodBrown = "woodBrown"
	case wineBurgundy = "wineBurgundy"
	
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
		}
	}
}
