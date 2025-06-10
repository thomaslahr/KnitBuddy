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
			MainAppView()
        }
		.modelContainer(for: [RowNumber.self, Counter.self, Project.self])
    }
	
	init() {
		print(URL.applicationSupportDirectory.path(percentEncoded: false))
	}
}
