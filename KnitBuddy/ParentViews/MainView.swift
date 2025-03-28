//
//  MainView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

struct MainView: View {
	
	@State private var selectedTab: Tabs = .simpleCounter
    var body: some View {
		VStack {
			switch selectedTab {
			case .simpleCounter:
				SimpleCounter()
			case .customCounter:
				CustomCounterView()
			}
		}
		.overlay(alignment: .bottom) {
			CustomTabBar(selectedTab: $selectedTab)
		}
    }
}

#Preview {
    MainView()
}
