//
//  MainAppView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftUI

struct MainAppView: View {
	
	@State private var selectedTab: Tabs = .simpleCounterView
	@StateObject private var keyboardObserver = KeyboardObserver()
	
    var body: some View {
		NavigationStack {
			VStack {
				switch selectedTab {
				case .simpleCounterView:
					SimpleCounter()
				case .projectView:
					ProjectListView()
				}
			}
			.overlay(alignment: .bottom) {
				if !keyboardObserver.isKeyboardVisible {
								CustomTabBar(selectedTab: $selectedTab)
							}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.peachBeige)
    }
}

#Preview {
    MainAppView()
}

import SwiftUI
import Combine


class KeyboardObserver: ObservableObject {
	@Published var isKeyboardVisible = false
	private var cancellables = Set<AnyCancellable>()

	init() {
		NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
			.sink { _ in
				DispatchQueue.main.async {
					self.isKeyboardVisible = true
				}
			}
			.store(in: &cancellables)

		NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
			.sink { _ in
				DispatchQueue.main.async {
					self.isKeyboardVisible = false
				}
			}
			.store(in: &cancellables)
	}
}
