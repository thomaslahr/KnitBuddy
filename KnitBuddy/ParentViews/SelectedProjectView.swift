//
//  SelectedProjectView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI

struct SelectedProjectView: View {
	//@Query var counters: [Counter]
	@Query var projects: [Project]
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	@State private var isAddingCounter = false
	
	//let project: Project?
	
	var selectedProjectID: PersistentIdentifier?
	var project: Project? {
		projects.first(where: {$0.persistentModelID == selectedProjectID})
	}
	
	@State private var showProjectNotes = false
	var body: some View {
		
		if let project {
		//	let firstProjectColor = project.counters.first?.color ?? .flameOrange
			VStack {
				HStack {
					Button {
						withAnimation {
							showProjectNotes.toggle()
						}
					} label: {
						Image(systemName: showProjectNotes ? "book.circle" : "book.closed.circle")
							.font(.system(size: 40))
							.fontWeight(.light)
							.foregroundStyle(project.color)
					}
					
					Spacer()
					TitleView(title: project.name, size: 28.0, colorStyle: GradientColors.custom(project.color).gradient)
						.frame(maxWidth: .infinity)
					Spacer()
					Button {
						isAddingCounter.toggle()
					} label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 40))
							.fontWeight(.light)
							.foregroundStyle(project.color)
					}
				}
				.padding(.horizontal)
				.border(.black, width: 2)
				
				ScrollView {
					VStack(spacing: 0) {
						ForEach(project.counters, id: \.id) { counter in
							CustomCounterComponentView(counter: counter)
								.padding(.bottom, 15)
						}
						.padding(.horizontal)
					}
					.animation(.linear(duration: 0.15), value: project.counters.count)
					.padding(.bottom, 50)
					
					
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(.peachBeige)
				.sheet(isPresented: $isAddingCounter) {
					CreateCounterSheet(
						comesFromSimpleCounter: false,
						numberOfRows: 0,
						project: project
					)
					.presentationDetents([.medium])
				}
				.sheet(isPresented: $showProjectNotes) {
					ProjectNotesView(project: project)
						
				}
			}
			.background(.peachBeige)
		}
	}
}

#Preview {
	SelectedProjectView(selectedProjectID: nil)
		.modelContainer(for: Counter.self, inMemory: true)
}

