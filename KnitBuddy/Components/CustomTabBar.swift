//
//  CustomTabBar.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

enum Tabs: Int {
	case simpleCounterView = 0
	case projectView = 1
}

struct CustomTabBar: View {
	@Binding var selectedTab: Tabs
	
	var body: some View {
		HStack {
			Button {
				selectedTab = .simpleCounterView
			} label: {
				Image(systemName: "checklist")
					.font(.system(size: 30))
					.foregroundStyle(selectedTab == .simpleCounterView ? .flameOrange : .gray)
			}
			.padding(.trailing, 50)
			Button {
				selectedTab = .projectView
			} label: {
				Image(systemName: "chart.pie")
					.font(.system(size: 30))
					.foregroundStyle(selectedTab == .projectView ? .flameOrange : .gray)
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
		.frame(maxWidth: 200, maxHeight: 60)
		.background {
			RoundedRectangle(cornerRadius: 20)
				.fill(GradientColors.primaryAppColor)
		}
		.shadow(color: .lightBlack.opacity(0.2), radius: 5)
	}
}

#Preview {
	CustomTabBar(selectedTab: .constant(.simpleCounterView))
}
