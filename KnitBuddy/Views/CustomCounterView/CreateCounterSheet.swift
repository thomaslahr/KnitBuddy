//
//  CustomCounterSheetView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI

struct CreateCounterSheet: View {
	let comesFromSimpleCounter: Bool
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@FocusState var isInputActive: Bool
	@State private var counterName = ""
	@State private var selectedColor = CounterColorEnum.flameOrange.rawValue
	let numberOfRows: Int
	
	
	let colors = CounterColorEnum.allCases
	
	let project: Project?
	
    var body: some View {
		VStack {
			//Titleview
			TitleView(title: comesFromSimpleCounter ? "Add Stitches to New Counter" : "Create a new counter", size: 24.0, colorStyle: .flameOrange)
			TextField(text: $counterName) {
				Text("Enter name of counter")
					.foregroundStyle(.lightBlack)
			}
			.foregroundStyle(.black)
			.padding()
			.focused($isInputActive)
			.background {
				RoundedRectangle(cornerRadius: 12)
					.fill(.white)
					.shadow(radius: 2)
				
			}

			.padding(.horizontal)
			if comesFromSimpleCounter {
				HStack(spacing: 5) {
					TitleView(title: "Number of stitches:", size: 20.0, colorStyle: .flameOrange)
					Text("\(numberOfRows)")
							.font(.system(size: 35))
							.foregroundStyle(.white)
							.frame(maxWidth: 70, maxHeight: 45)
							.background {
								RoundedRectangle(cornerRadius: 12)
									.fill(GradientColors.primaryAppColor)
							}
				}
			}
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
				
				guard let project = project else { return }
				let newCounter = Counter(name: counterName, counterColor: selectedColor, rows: comesFromSimpleCounter ? numberOfRows : 0)
				
				project.counters.append(newCounter)
				modelContext.insert(newCounter)
				try? modelContext.save()
				
				dismiss()
			} label: {
				ZStack {
					RoundedRectangle(cornerRadius: 12)
						.stroke(lineWidth: 3)
						.frame(maxWidth: 160, maxHeight: 60)
					Text("Create Counter")
						.fontWeight(.black)
						.fontDesign(.rounded)
				}
				.foregroundStyle(counterName.isEmpty ? .lightBlack.opacity(0.3) : .flameOrange)
			}
			.disabled(counterName.isEmpty)
			.padding()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.peachBeige)
		.onAppear {
			isInputActive = true
		}
    }
}

#Preview {
	CreateCounterSheet(
		comesFromSimpleCounter: true,
		numberOfRows: 45,
		project: Project.sampleProject
	)
}
