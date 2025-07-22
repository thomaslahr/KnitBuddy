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
	
	var selectedProjectID: PersistentIdentifier?
	var project: Project? {
		projects.first(where: {$0.persistentModelID == selectedProjectID})
	}
	
	@State private var showProjectNotes = false
	@State private var showAlert = false
	var body: some View {
		
		if let project {
		//	let firstProjectColor = project.counters.first?.color ?? .flameOrange
			VStack {
				TitleView(title: project.name, size: project.name.count > 12 ? 15.0 : 22.0, colorStyle: GradientColors.custom(project.color).gradient)
						.frame(maxWidth: .infinity)
						.overlay {
							HStack(spacing: 3) {
									Button {
										dismiss()
									} label: {
										Image(systemName: "chevron.backward.circle")
											.font(.system(size: 40))
											.fontWeight(.light)
											.foregroundStyle(project.color)
									}
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
								Button {
									isAddingCounter.toggle()
								} label: {
									Image(systemName: "square.and.pencil.circle")
										.font(.system(size: 40))
										.fontWeight(.light)
										.foregroundStyle(project.color)
								}
							}
						}
					//	.border(.green, width: 2)
					
				.padding(5)
			//	.border(.black, width: 2)
				
				ScrollView {
					VStack(spacing: 0) {
						ForEach(project.counters.indices, id: \.self) { index in
							CustomCounterComponentView(counter: project.counters[index])
								.padding(.bottom, 10)
								.onLongPressGesture(minimumDuration: 0.3) {
									if !project.counters[index].isLocked {
										showAlert = true
									}
								}
								.alert("Delete Counter?", isPresented: $showAlert) {
									Button("Cancel", role: .cancel, action: { })
									Button("Delete", role: .destructive) {
										deleteCounter(counter: project.counters[index])
									}
								} message: {
									Text("Are you sure? This cannot be undone.")
								}
							
								//.shadow(color: .lightBlack.opacity(0.2), radius: 5)
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
			.navigationBarBackButtonHidden(true)
		}
	}
	private func deleteCounter(counter: Counter) {
		modelContext.delete(counter)
		try? modelContext.save()
		
		showAlert = false
	}
}

#Preview {
	SelectedProjectView(selectedProjectID: nil)
		.modelContainer(for: Counter.self, inMemory: true)
}

