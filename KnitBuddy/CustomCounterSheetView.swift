//
//  CustomCounterSheetView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI

struct CustomCounterSheetView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@State private var counterName = ""
	
	
    var body: some View {
		VStack {
			TextField("Enter name of counter", text: $counterName)
			Button {
				let newCounter = Counter(name: counterName)
				modelContext.insert(newCounter)
				try? modelContext.save()
				
				dismiss()
			} label: {
				Text("Create Counter")
			}
		}
    }
}

#Preview {
    CustomCounterSheetView()
}
