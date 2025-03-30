//
//  NotesView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 30/03/2025.
//

import SwiftData
import SwiftUI

struct NotesView: View {
	@Bindable var counter: Counter
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@State private var showingAlert = false
	
    var body: some View {
		VStack {
			TitleView(title: counter.name, size: 20, colorStyle: counter.color)
				.frame(maxWidth: .infinity)
				.overlay(alignment: .trailing) {
					Button {
						showingAlert.toggle()
					} label: {
						Image(systemName: "trash.circle")
							.font(.system(size: 40))
							.fontWeight(.light)
							.foregroundStyle(counter.color)
							.padding(.trailing, 20)
					}
				}
			ScrollView {
				SmallTitleView(title: "Date created: \(counter.dateCreated.formatted(date: .numeric, time: .shortened))", size: 15.0, color: counter.color)
				VStack{
					NotesEditorView(counterNotes: $counter.notes.notes, viewTitle: "Notes", minHeight: 200, maxHeight: 300, colorStyle: counter.color)
					NotesEditorView(counterNotes: $counter.notes.details, viewTitle: "Details", minHeight: 200, maxHeight: 200, colorStyle: counter.color)
					NotesEditorView(counterNotes: $counter.notes.yarn, viewTitle: "Yarn", minHeight: 200, maxHeight: 200, colorStyle: counter.color)
				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.peachBeige)
		.alert("Delete Counter?", isPresented: $showingAlert) {
			Button("Cancel", role: .cancel, action: { })
			Button("Delete", role: .destructive, action: deleteCounter)
		} message: {
			Text("Are you sure? This cannot be undone.")
		}
    }
	
	private func deleteCounter() {
		dismiss()
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			modelContext.delete(counter)
			try? modelContext.save()
		}
	}
}

#Preview {
	NotesView(counter: Counter(name: "Hello, there"))
}
