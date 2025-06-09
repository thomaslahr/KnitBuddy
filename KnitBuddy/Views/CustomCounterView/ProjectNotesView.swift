//
//  ProjectNotesView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 30/03/2025.
//

import SwiftData
import SwiftUI

struct ProjectNotesView: View {
	@Bindable var project: Project
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@State private var showingAlert = false
	@State private var editTitle = false
	@FocusState var isInputActive: Bool
	
	var body: some View {
		VStack {
			HStack {
				if editTitle {
					TextField(project.name, text: $project.name)
						.focused($isInputActive)
						.font(.system(size: 20))
						.fontWeight(.black)
						.fontDesign(.rounded)
						.foregroundStyle(project.color)
						.multilineTextAlignment(.center)
						.frame(height: 24)
				} else {
					TitleView(title: project.name, size: 20, colorStyle: project.color)
						.frame(height: 24)
				}
				
			}
			.padding()
			.frame(maxWidth: .infinity)
			.overlay(alignment: .leading) {
				Button {
					editTitle.toggle()
				} label: {
					Image(systemName: editTitle ? "checkmark.circle.fill" : "pencil.circle")
						.font(.system(size: 40))
						.fontWeight(.light)
						.foregroundStyle(project.color)
						.padding(.leading, 20)
				}
			}
			ScrollView {
				SmallTitleView(title: "Date created: \(project.dateCreated.formatted(date: .numeric, time: .shortened))", size: 15.0, color: project.color)
				VStack{
					NotesEditorView(projectNotes: $project.notes.notes, viewTitle: "Notes", minHeight: 200, maxHeight: 300, colorStyle: project.color, hideTitle: false)
					NotesEditorView(projectNotes: $project.notes.details, viewTitle: "Details", minHeight: 200, maxHeight: 200, colorStyle: project.color, hideTitle: false)
					NotesEditorView(projectNotes: $project.notes.yarn, viewTitle: "Yarn", minHeight: 200, maxHeight: 200, colorStyle: project.color, hideTitle: false)
				}
			}
		}
		.onChange(of: editTitle, {
			isInputActive = true
		})
		.onChange(of: project.name) {
			try? modelContext.save()
		}
		
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.peachBeige)
	}
}

#Preview {
	ProjectNotesView(project: Project.sampleProject)
}
