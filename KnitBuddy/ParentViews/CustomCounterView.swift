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
			TitleView(title: "KnitBuddy")
				.overlay(alignment: .trailing) {
					Button {
						isAddingCounter.toggle()
					} label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 40))
							.fontWeight(.light)
							.foregroundStyle(.flameOrange)
					}
					.padding(.trailing, 20)
				}
			ScrollView {
				VStack(spacing: 0) {
					ForEach(counters.indices, id: \.self) { index in
						
						let counter = counters[index]
						
						Text(counter.name.uppercased())
							.foregroundStyle(counter.color)
							.fontWeight(.bold)
						
						CustomCounterComponentView(counter: counter)
						
						if index < counters.count - 1 {
							DividerView()
						}
					}
					.padding(.horizontal)
				}
				.padding(.bottom, 50)
				

			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.peachBeige)
			.sheet(isPresented: $isAddingCounter) {
				CustomCounterSheetView()
					.presentationDetents([.medium])
			}
		}
		.background(.peachBeige)
    }
}

#Preview {
    CustomCounterView()
		.modelContainer(for: Counter.self, inMemory: true)
}
