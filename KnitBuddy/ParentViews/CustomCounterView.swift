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
		let firstCounterColor = counters.first?.color ?? .flameOrange
		VStack {
			TitleView(title: "Stitch Counters", size: 28.0, colorStyle: GradientColors.custom(firstCounterColor).gradient)
				.frame(maxWidth: .infinity)
				.overlay(alignment: .trailing) {
					Button {
						isAddingCounter.toggle()
					} label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 40))
							.fontWeight(.light)
							.foregroundStyle(firstCounterColor)
					}
					.padding(.trailing, 20)
				}
			
			ScrollView {
				VStack(spacing: 0) {
					ForEach(counters.indices, id: \.self) { index in
						
						let counter = counters[index]
						
						Text(counter.name.uppercased())
							.frame(maxWidth: .infinity, alignment: .leading)
							.foregroundStyle(counter.color)
							.fontWeight(.bold)
						
						CustomCounterComponentView(counter: counter)
							.transition(.asymmetric(
								insertion: .move(edge: .trailing)
									.combined(with: .opacity),
								removal: .opacity))
						
						if index < counters.count - 1 {
							DividerView(color: counter.color)
						}
					}
					.padding(.horizontal)
				}
				.animation(.linear(duration: 0.15), value: counters.count)
				.padding(.bottom, 50)
				

			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.peachBeige)
			.sheet(isPresented: $isAddingCounter) {
				CustomCounterSheetView(comesFromSimpleCounter: false, numberOfRows: 0)
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

