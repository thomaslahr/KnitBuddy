//
//  CreateProjectsView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 09/06/2025.
//

import SwiftUI
import SwiftData


struct CreateProjectsView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
	@State private var name = ""
	
	let colors = CounterColorEnum.allCases
	@State private var selectedColor = CounterColorEnum.flameOrange.rawValue
	
    var body: some View {
			VStack {
				TitleView(title: "Create a New Project", size: 24.0, colorStyle: colorFromRawValue(selectedColor))
				TextField(text: $name) {
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
					.padding(.bottom, 20)
				VStack {
					Text("Choose a Color")
						.foregroundStyle(colorFromRawValue(selectedColor))
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
				.padding(.bottom, 30)
				Button {
					let newProject = Project(
						name: name,
						counters: [],
						dateCreated: .now,
						projectColor: selectedColor
						)
					
					modelContext.insert(newProject)
					try? modelContext.save()
					
					dismiss()
				} label: {
					ZStack {
						RoundedRectangle(cornerRadius: 12)
							.stroke(lineWidth: 3)
							.frame(maxWidth: 160, maxHeight: 60)
						Text("Create Project")
							.fontWeight(.black)
							.fontDesign(.rounded)
					}
					.foregroundStyle(name.isEmpty ? .lightBlack.opacity(0.3) : colorFromRawValue(selectedColor))
				}
			}
			.padding()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.peachBeige)
    }

	func colorFromRawValue(_ rawValue: String) -> Color {
		CounterColorEnum(rawValue: rawValue)?.color ?? .flameOrange
	}
}

#Preview {
    CreateProjectsView()
}
