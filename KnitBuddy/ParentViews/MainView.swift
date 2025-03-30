//
//  MainView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

struct MainView: View {
	
	@State private var selectedTab: Tabs = .simpleCounter
	@StateObject private var keyboardObserver = KeyboardObserver()
	
    var body: some View {
		NavigationStack {
			VStack {
				switch selectedTab {
				case .simpleCounter:
					SimpleCounter()
				case .customCounter:
					CustomCounterView()
				}
			}
			.overlay(alignment: .bottom) {
				if !keyboardObserver.isKeyboardVisible {
								CustomTabBar(selectedTab: $selectedTab)
							}
			}
		}
    }
}

#Preview {
    MainView()
}

import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
	@Published var isKeyboardVisible = false
	private var cancellables = Set<AnyCancellable>()

	init() {
		NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
			.sink { _ in
				self.isKeyboardVisible = true
			}
			.store(in: &cancellables)

		NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
			.sink { _ in
				self.isKeyboardVisible = false
			}
			.store(in: &cancellables)
	}
}
