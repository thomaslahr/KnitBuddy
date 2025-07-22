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
	@FocusState var isEditingTitle: Bool
	
	@State private var buttonSymbol: ButtonSymbol = .edit
	@State private var newName = ""
	@State private var showAlert = false
	@State private var textSize: CGFloat = 20.0
	var body: some View {
		VStack {
			HStack {
				if editTitle {
					VStack {
						TextField(newName, text: $newName)
							.focused($isEditingTitle)
							.font(.system(size: textSize))
							.fontWeight(.black)
							.fontDesign(.rounded)
							.foregroundStyle(project.color)
							.multilineTextAlignment(.center)
							.frame(height: 24)
							.onChange(of: newName) {
								if newName.count > 22 {
									newName = String(newName.prefix(22))
								}
								
								setTextSize(text: newName)
								print("\(newName), count: \(newName.count)")
							}
//						Text("The project name is too long.")
//							.font(.system(size: 12))
//							.fontWeight(.bold)
//							.foregroundStyle(.red)
//							.opacity(newName.count > 20 ? 1 : 0)
					}
				} else {
					TitleView(
						title: project.name,
						size: textSize,
						colorStyle: project.color
					)
					.frame(height: 24)
					.frame(maxWidth: .infinity)
				}
			}
			.padding()
			.frame(maxWidth: .infinity)
			.overlay(alignment: .leading) {
				Button {
					editTitle.toggle()
					
					if editTitle {
						isEditingTitle = true
						newName = project.name
						buttonSymbol = .save
					} else {
						buttonSymbol = .edit
						if !newName.isEmpty && newName.count <= 18 {
							project.name = newName
							
						}
					}
					if newName.count > 18 || newName.isEmpty {
						withAnimation(.easeInOut(duration: 0.3)) {
							showAlert = true
							print("Hallo hallo")
						}
						
						Task {
							try await Task.sleep(for: .seconds(1.5))
							withAnimation(.easeInOut(duration: 0.3)){
								showAlert = false
							}
						}
					}
				} label: {
					Image(systemName: buttonSymbol.currentSymbol)
					.font(.system(size: 40))
					.fontWeight(.light)
					.foregroundStyle(project.color)
				}
				.disabled(project.name.isEmpty || project.name.count > 18)
				.padding(.leading, 10)
			}
			ScrollView {
				SmallTitleView(
					title: "Date created: \(project.dateCreated.formatted(date: .numeric, time: .omitted))",
					size: 15.0,
					color: project.color
				)
				VStack{
					VStack {
						NotesEditorView(
							projectNotes: $project.notes.yarnInfo,
							isInputActive: $isInputActive,
							viewTitle: "Yarn",
							minHeight: 50,
							maxHeight: 200,
							colorStyle: project.color,
							hideTitle: false,
							maxNumberOfCharacters: 100
						)
						HStack {
							NotesEditorView(
								projectNotes: $project.notes.dyeLot,
								isInputActive: $isInputActive,
								viewTitle: "Dye Lot",
								minHeight: 40,
								maxHeight: 40,
								colorStyle: project.color,
								hideTitle: false,
								maxNumberOfCharacters: 10
							)
							NotesEditorView(
								projectNotes: $project.notes.color,
								isInputActive: $isInputActive,
								viewTitle: "Color",
								minHeight: 40,
								maxHeight: 40,
								colorStyle: project.color,
								hideTitle: false,
								maxNumberOfCharacters: 10
							)
						}
						
						HStack {
							NotesEditorView(
								projectNotes: $project.notes.needleType,
								isInputActive: $isInputActive,
								viewTitle: "Needle Type",
								minHeight: 40,
								maxHeight: 40,
								colorStyle: project.color,
								hideTitle: false,
								maxNumberOfCharacters: 15
							)
							
							HStack(alignment: .center) {
								NotesEditorView(
									projectNotes: $project.notes.needleThickness,
									isInputActive: $isInputActive,
									viewTitle: "Thickness",
									minHeight: 40,
									maxHeight: 40,
									colorStyle: project.color,
									hideTitle: false,
									maxNumberOfCharacters: 10
									
								)
							}
						}
					}
					NotesEditorView(
						projectNotes: $project.notes.details,
						isInputActive: $isInputActive,
						viewTitle: "Details",
						minHeight: 100,
						maxHeight: 200,
						colorStyle: project.color,
						hideTitle: false,
						maxNumberOfCharacters: 300
					)
					NotesEditorView(
						projectNotes: $project.notes.notes,
						isInputActive: $isInputActive,
						viewTitle: "Notes",
						minHeight: 200,
						maxHeight: 300,
						colorStyle: project.color,
						hideTitle: false,
						maxNumberOfCharacters: 1000
					)
					
					
				}
				.padding(.horizontal)
			}
			.onTapGesture {
				isInputActive = false
			}
		}
		.overlay(alignment: .bottom) {
			Text(newName.count > 20 ? "The project name was too long." : "The project name was too short.")
				.fontWeight(.bold)
				.fontDesign(.rounded)
				.foregroundStyle(project.color)
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 12)
						.fill(.thinMaterial)
				}
				.opacity(showAlert ? 1 : 0)
		}
		
		.onTapGesture {
			isInputActive = false
		}
		.onAppear {
			setTextSize(text: project.name)
		}
		.onChange(of: project.name) {
			if !project.name.isEmpty || project.name.count <= 20 {
				try? modelContext.save()
			}
		}
		.onChange(of: newName) {
			if newName.count > 20 || newName.isEmpty {
				buttonSymbol = .tooLongOrTooShort
			} else {
				buttonSymbol = .save
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.peachBeige)
	}
	
	private func setTextSize(text: String) {
		if text.count > 15 {
			textSize = 13.0
		} else {
			textSize = 20.0
		}
	}
}

#Preview {
	ProjectNotesView(project: Project.sampleProject)
}
