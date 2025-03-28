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
	case mangoYellow = "mangoYellow"
	
	var color: Color {
		
		switch self {
		case .flameOrange:
				.flameOrange
		case .jungleTeal:
				.jungleTeal
		case .stormBlue:
				.stormBlue
		case .mangoYellow:
				.mangoYellow
		}
	}
}
