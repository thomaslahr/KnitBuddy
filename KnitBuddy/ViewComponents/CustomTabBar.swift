//
//  CustomTabBar.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

enum Tabs: Int {
	case simpleCounter = 0
	case customCounter = 1
}

struct CustomTabBar: View {
	@Binding var selectedTab: Tabs
	
	var body: some View {
		HStack {
			Button {
				selectedTab = .simpleCounter
			} label: {
				Image(systemName: "checklist")
					.font(.system(size: 30))
					.foregroundStyle(selectedTab == .simpleCounter ? .flameOrange : .gray)
			}
			.padding(.trailing, 50)
			Button {
				selectedTab = .customCounter
			} label: {
				Image(systemName: "chart.pie")
					.font(.system(size: 30))
					.foregroundStyle(selectedTab == .customCounter ? .flameOrange : .gray)
			}
			
//			Button {
//				selectedTab = .overview
//			} label: {
//				Image(systemName: "sun.max.circle.fill")
//					.font(.system(size: 30))
//					.foregroundStyle(selectedTab == .overview ? .lightWatermelon : .gray)
//			}
//			.padding(.leading, 50)
		}
		.frame(maxWidth: 300, maxHeight: 60)
		.background {
			RoundedRectangle(cornerRadius: 20)
				.fill(GradientColors.primaryAppColor)
		}
	}
}

#Preview {
	CustomTabBar(selectedTab: .constant(.simpleCounter))
}
