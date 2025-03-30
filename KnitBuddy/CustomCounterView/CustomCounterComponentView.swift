//
//  CustomCounterComponentView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI


struct CustomCounterComponentView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@Bindable var counter: Counter
	@State private var showingAlert = false
	
	
	var body: some View {
		HStack(spacing: 0) {
			HStack {
				HStack(spacing: 15) {
					//Delete button
					Button {
						showingAlert.toggle()
					} label: {
						Image(systemName: "trash.circle")
							.frame(width: 40, height: 40)
					}
					.disabled(counter.isLocked)
					
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
		.alert("Delete Habit?", isPresented: $showingAlert) {
			Button("Cancel", role: .cancel, action: { })
			Button("Delete", role: .destructive, action: deleteCounter)
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

	private func deleteCounter() {
		modelContext.delete(counter)
		saveChanges()
		dismiss()
	}

}

#Preview {
	CustomCounterComponentView(counter: Counter(name: "Arm", counterColor: "flameOrange"))
}
