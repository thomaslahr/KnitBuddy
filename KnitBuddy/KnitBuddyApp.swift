//
//  KnitBuddyApp.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI
import SwiftData

@main
struct KnitBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
		.modelContainer(for: [YarnNotes.self, RowNumber.self, Counter.self])
    }
	
	init() {
		print(URL.applicationSupportDirectory.path(percentEncoded: false))
	}
}
