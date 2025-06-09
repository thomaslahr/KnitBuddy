//
//  NotesEditorView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 30/03/2025.
//

import SwiftUI
import SwiftData

struct NotesEditorView<T: ShapeStyle>: View {
	
	@Binding var projectNotes: String
	@Environment(\.modelContext) private var modelContext
	@FocusState var isInputActive: Bool
	@State private var debounceTimer: Timer?
	
	let viewTitle: String
	let minHeight: CGFloat
	let maxHeight: CGFloat
	let colorStyle: T
	
	@Query var counters: [Counter]
	
	let hideTitle: Bool
	
	var body: some View {
		VStack{
			if !hideTitle {
				Text(viewTitle)
					.fontWeight(.semibold)
					.frame(maxWidth: .infinity, alignment: .leading)
					.foregroundStyle(colorStyle)
			}
			TextEditor(text: $projectNotes)
				.foregroundStyle(.black)
				.lineSpacing(5)
				.cornerRadius(10)
				.scrollContentBackground(.hidden)
				//.background(Color(.systemGray6))
				.background(.peachBeige)
				.overlay {
					RoundedRectangle(cornerRadius: 8)
						.stroke(colorStyle, lineWidth: 2)
				}
				//.submitLabel(.done)
				.frame(minHeight: minHeight)
				.frame(maxHeight: maxHeight)
				.focused($isInputActive)
				.onChange(of: projectNotes) { oldValue, newValue in
					debounceSave(newValue)
				}
			
		}
		.background {
			RoundedRectangle(cornerRadius: 8)
				//.fill(Color(.systemGray6))
				.fill(.peachBeige)
		}
	}
	
	private func debounceSave(_ newValue: String) {
		debounceTimer?.invalidate()
		
		debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {_ in
			saveNotes(newValue)
		}
	}
	
	private func saveNotes(_ newValue: String) {
		do {
			try modelContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
	NotesEditorView(projectNotes: .constant("This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn."), viewTitle: "Notes", minHeight: 250, maxHeight: 400, colorStyle: .flameOrange, hideTitle: false)
}
