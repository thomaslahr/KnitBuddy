//
//  ProjectListView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 08/06/2025.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
	
	@Query var projects: [Project]
	
	@State private var selectedProject: Project?
	@State private var showCreateProjectSheet = false
	@State private var selectedProjectID: PersistentIdentifier?
	var body: some View {
		VStack {
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
				VStack {
					ForEach(projects, id: \.self) { project in
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
										.fill(.flameOrange)
								}
						}
					}
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
				.border(.black, width: 2)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(.peachBeige)
		.sheet(item: $selectedProjectID) { id in
			SelectedProjectView(selectedProjectID: id)
		}
		.sheet(isPresented: $showCreateProjectSheet) {
			CreateProjectsView()
		}
		
	}
}

#Preview {
	ProjectListView()
}
