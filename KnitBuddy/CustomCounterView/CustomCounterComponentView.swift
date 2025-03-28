//
//  CustomCounterComponentView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 28/03/2025.
//

import SwiftData
import SwiftUI

//Some comment
struct CustomCounterComponentView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@Bindable var counter: Counter
	@State private var showingAlert = false
	
	
	var body: some View {
		HStack {
			HStack {
				Text(counter.name.uppercased())
					.foregroundStyle(.peachBeige)
					.fontDesign(.rounded)
					.font(.system(size: 10))
					.fontWeight(.bold)
					.fixedSize()
					.frame(width: 20, height: 80)
					.rotationEffect(.degrees(270))
					.padding(.leading, -15)
				Group {
					Button {
						showingAlert.toggle()
					} label: {
						Image(systemName: "trash.circle")
					}
					
					Button {
						if counter.rows > 0 {
							counter.rows -= 1
							saveChanges()
						}
					} label: {
						Image(systemName: "minus.circle")
					}
					.padding(.horizontal, 20)
				}
				.font(.system(size: 40))
				.fontWeight(.bold)
				
				Spacer()
				
				Text("\((counter.rows))")
					.font(.system(size: 55))
					.fontWeight(.semibold)
					.foregroundStyle(.white)
			}
			.frame(maxHeight: 100)
			.padding(.horizontal, 20)
			.foregroundStyle(.peachBeige)
			.background {
				RoundedRectangle(cornerRadius: 8)
				//	.fill((Color(.systemGray6)))
					.fill(counter.color)
			}
			HStack {
				Button {
					counter.rows += 1
					saveChanges()
				} label: {
					Image(systemName: "plus.circle")
						.font(.system(size: 90))
						.fontWeight(.semibold)
						//.foregroundStyle(GradientColors.primaryAppColor)
						.foregroundStyle(counter.color)
				}
			}
		}
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
