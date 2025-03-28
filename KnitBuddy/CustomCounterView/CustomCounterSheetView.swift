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
	@State private var selectedColor = CounterColorEnum.flameOrange.rawValue
	
	let colors = CounterColorEnum.allCases
	
	
    var body: some View {
		VStack {
			//Titleview
			TitleView(title: "Create a new counter")
			TextField(text: $counterName) {
				Text("Enter name of counter")
					.foregroundStyle(.lightBlack)
			}
			.foregroundStyle(.black)
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 12)
					.fill(.white)
					.shadow(radius: 2)
				
			}
			.padding(.horizontal)
			
			VStack(spacing: 10) {
				Text("Choose a Color")
					.foregroundStyle(.lightBlack)
					.font(.system(size: 20))
					.fontWeight(.black)
					.fontDesign(.rounded)
				HStack {
					ForEach(colors, id: \.self) { color in
						Button {
							selectedColor = color.rawValue
						} label: {
							RoundedRectangle(cornerRadius: 8)
								.scaledToFit()
								.frame(maxWidth: 50)
								.foregroundStyle(color.color)
								.overlay {
									RoundedRectangle(cornerRadius: 8)
										.stroke(selectedColor == color.rawValue ? .lightBlack : .clear, lineWidth: 2.5)
								}
						}
					}
				}
			}
			.padding()
			Button {
				let newCounter = Counter(name: counterName, counterColor: selectedColor)
				modelContext.insert(newCounter)
				try? modelContext.save()
				
				dismiss()
			} label: {
				ZStack {
					RoundedRectangle(cornerRadius: 12)
						.stroke(lineWidth: 3)
						.frame(maxWidth: 160, maxHeight: 60)
					Text("Create Counter")
				}
				.foregroundStyle(counterName.isEmpty ? .lightBlack.opacity(0.3) : .flameOrange)
			}
			.disabled(counterName.isEmpty)
			.padding()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.peachBeige)
    }
}

#Preview {
    CustomCounterSheetView()
}
