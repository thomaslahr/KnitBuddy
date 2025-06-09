//
//  ProjectListView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 08/06/2025.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
	@Environment(\.modelContext) private var modelContext
	@Query var projects: [Project]
	
	@State private var selectedProject: Project?
	@State private var showCreateProjectSheet = false
	@State private var selectedProjectID: PersistentIdentifier?
	
	@State private var showAlert = false
	
	var body: some View {
		NavigationStack {
			TitleView(title: "Projects", size: 28.0, colorStyle: .flameOrange)
				.frame(maxWidth: .infinity)
				.overlay(alignment: .topTrailing) {
					Button {
						showCreateProjectSheet.toggle()
					} label: {
						Image(systemName: "plus.circle")
							.foregroundStyle(.flameOrange)
							.font(.system(size: 40))
							.fontWeight(.light)
					}
					.padding(.trailing, 20)
				}
			ScrollView {
				VStack(alignment: .leading) {
					ForEach(projects, id: \.self) { project in
						HStack {
							Button {
								selectedProjectID = project.persistentModelID
							} label: {
								Text(project.name)
									.font(.title2)
									.fontWeight(.bold)
									.fontDesign(.rounded)
									.foregroundStyle(.peachBeige)
									.padding()
									.background {
										RoundedRectangle(cornerRadius: 12)
											.fill(GradientColors.custom(project.color).gradient)
									}
							}
							Spacer()
							
							Button {
								showAlert.toggle()
								selectedProject = project
							} label: {
								Image(systemName: "trash.circle")
									.font(.system(size: 40))
									.fontWeight(.light)
									.foregroundStyle(project.color)
							}
						}
					}
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
				.border(.black, width: 2)
				.alert("Delete Project?", isPresented: $showAlert) {
					Button("Cancel", role: .cancel, action: { })
					Button("Delete", role: .destructive) {
						if let selectedProject {
							deleteProject(project: selectedProject)
						}
					}
				} message: {
					Text("Are you sure? This cannot be undone.")
				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(.peachBeige)
		.navigationDestination(item: $selectedProjectID) { id in
			SelectedProjectView(selectedProjectID: id)
		}
		
		.sheet(isPresented: $showCreateProjectSheet) {
			CreateProjectsView()
		}
		
	}
	
	private func deleteProject(project: Project) {

		Task {
			try await Task.sleep(for: .seconds(0.5))
			modelContext.delete(project)
			try? modelContext.save()
		}
	}
}

#Preview {
	ProjectListView()
}
