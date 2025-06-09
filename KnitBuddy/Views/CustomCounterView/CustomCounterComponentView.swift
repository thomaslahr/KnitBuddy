//
//  CustomCounterComponentView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI

struct CustomCounterComponentView: View {
	@Environment(\.modelContext) private var modelContext
	@Bindable var counter: Counter
	
	@State private var showCounterNotes = false
	@State private var fadeInCounterNotes = false
	
	@State private var showingAlert = false
	var body: some View {
		VStack(spacing: 5) {
			HStack {
				Text(counter.name.uppercased())
					.foregroundStyle(counter.color)
					.fontWeight(.bold)
				
				Button {
					showingAlert.toggle()
				} label: {
					Image(systemName: "trash.circle")
						.fontWeight(.light)
						.foregroundStyle(counter.isLocked ? .gray : counter.color)
						.padding(.trailing, 20)
				}
				.disabled(counter.isLocked)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			HStack(spacing: 0) {
				HStack {
					HStack(spacing: 15) {
						Button {
							if !fadeInCounterNotes {
								withAnimation(.easeInOut(duration: 0.3)) {
										showCounterNotes = true
									}
								
								Task {
									try await Task.sleep(for: .seconds(0.2))
									withAnimation {
										fadeInCounterNotes = true
									}
								}
							} else {
								withAnimation(.easeInOut(duration: 0.2)) {
									fadeInCounterNotes = false
								}
								
								Task {
									try await Task.sleep(for: .seconds(0.075))
									withAnimation {
										showCounterNotes = false
									}
								}
							}
							
						} label: {
							Image(systemName: showCounterNotes ? "book.circle" : "book.closed.circle")
								.frame(width: 40, height: 40)
								.foregroundStyle(.peachBeige)
						}
						//.disabled(counter.isLocked)
						
						//Lock button
						Button {
							withAnimation(.linear(duration: 0.1)){
								counter.isLocked.toggle()
							}
							saveChanges()
						} label: {
							Image(systemName: counter.isLocked ? "lock.fill" : "lock.open.fill")
								.frame(width: 40, height: 40)
								.foregroundStyle(.peachBeige)
						}
						
						
						// Minus button
						Button {
							if counter.rows > 0 {
								counter.rows -= 1
								saveChanges()
							}
						} label: {
							Image(systemName: "minus.circle")
						}
						.disabled(counter.isLocked)
					}
					.font(.system(size: 40))
					.fontWeight(.bold)
					
					Spacer()
					//Counter text view
					Text("\((counter.rows))")
						.font(.system(size: counter.rows > 9 ? 35 : 50))
						.fontWeight(.semibold)
						.foregroundStyle(.white)
				}
				.frame(maxWidth: .infinity, maxHeight: 100)
				.padding(.horizontal, 20)
				.foregroundStyle(counter.isLocked ? .lightBlack : .peachBeige)
				.background {
					RoundedRectangle(cornerRadius: 8)
					//	.fill((Color(.systemGray6)))
						.fill(GradientColors.custom(counter.color).gradient)
				}
				// Add to counter button
				HStack {
					Button {
						counter.rows += 1
						saveChanges()
					} label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 90))
							.fontWeight(.semibold)
							//.foregroundStyle(GradientColors.primaryAppColor)
							.foregroundStyle(counter.isLocked ? .lightBlack : counter.color)
					}
					.disabled(counter.isLocked)
				}
			}
			.transition(.opacity)
			.animation(.linear(duration: 0.15), value: counter.isLocked)
			
			if showCounterNotes {
				NotesEditorView(projectNotes: $counter.notes, viewTitle: counter.name, minHeight: 50, maxHeight: 200, colorStyle: counter.color, hideTitle: true)
					.transition(.move(edge: .top))
					.animation(.easeInOut(duration: 0.3), value: showCounterNotes)
					.opacity(fadeInCounterNotes ? 1 : 0)
			}
		}
		.alert("Delete Counter?", isPresented: $showingAlert) {
			Button("Cancel", role: .cancel, action: { })
			Button("Delete", role: .destructive) {
					deleteCounter(counter: counter)
			}
		} message: {
			Text("Are you sure? This cannot be undone.")
		}
	}
	
	private func saveChanges() {
		do {
			try modelContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func deleteCounter(counter: Counter) {
		modelContext.delete(counter)
		try? modelContext.save()
	}
}

#Preview {
	CustomCounterComponentView(counter: Counter(name: "Arm", counterColor: "flameOrange"))
}
