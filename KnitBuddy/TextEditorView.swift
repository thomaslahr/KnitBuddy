//
//  TextEditorView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI
import SwiftData

struct TextEditorView: View {
	@Binding var yarnDetails: String
	@Environment(\.modelContext) private var modelContext
	@State private var debounceTimer: Timer?
	
	@Query var existingYarnDetail: [YarnNotes]
	
    var body: some View {
		VStack{
			Text("Yarn Notes")
				.fontWeight(.semibold)
				.frame(maxWidth: .infinity, alignment: .leading)
				.foregroundStyle(.black)
			TextEditor(text: $yarnDetails)
				.foregroundStyle(.black)
				.lineSpacing(5)
				.cornerRadius(10)
				.padding(5)
				.scrollContentBackground(.hidden)
				//.background(Color(.systemGray6))
				.background(.peachBeige)
				.overlay {
					RoundedRectangle(cornerRadius: 8)
						.stroke(.flameOrange, lineWidth: 2)
				}
				//.submitLabel(.done)
				.frame(minHeight: 250)
				.onChange(of: yarnDetails) { oldValue, newValue in
					debounceSave(newValue)
				}
			
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 8)
				//.fill(Color(.systemGray6))
				.fill(.peachBeige)
		}
		.onTapGesture {
			dismissKeyboard()
		}
		.onSubmit {
			dismissKeyboard()
		}
		.onAppear {
			if let existingYarnDetail = existingYarnDetail.first {
				yarnDetails = existingYarnDetail.text
			}
		}
    }
	private func debounceSave(_ newValue: String) {
		debounceTimer?.invalidate()
		
		debounceTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
			saveYarnDetails(newValue)
		}
	}
	private func saveYarnDetails(_ newValue: String) {
		
		let yarnDetail: YarnNotes
		if let existingYarnDetail = existingYarnDetail.first {
			yarnDetail = existingYarnDetail
		} else {
			yarnDetail = YarnNotes(text: "")
			modelContext.insert(yarnDetail)
		}
		yarnDetail.text = newValue
		for oldYarnDetail in existingYarnDetail.dropFirst() {
			modelContext.delete(oldYarnDetail)
		}
		
		do {
			try modelContext.save()
			print("Yarn details was saved to SwiftData")
		} catch {
			print("Couldn't save the yarn details to SwiftData.")
		}
	}
	
	private func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
	TextEditorView(yarnDetails: .constant("This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn. This is a very good yarn."))
		.frame(maxHeight: 400)
}
