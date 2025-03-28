//
//  CustomCounterView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI

struct CustomCounterView: View {
	@Query var counters: [Counter]
	@State private var isAddingCounter = false
	
    var body: some View {
		VStack {
			List {
				ForEach(counters) { counter in
					HStack {
						Text(counter.name)
						Text("\(counter.rows)")
					}
				}
			}
			Button {
				isAddingCounter.toggle()
			} label: {
				Text("Add Counter")
			}
		}
		.sheet(isPresented: $isAddingCounter) {
			CustomCounterSheetView()
		}
    }
}

#Preview {
    CustomCounterView()
		.modelContainer(for: Counter.self, inMemory: true)
}
