//
//  MainView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
	@Environment(\.modelContext) private var modelContext
	@Query var yarnDetails: [YarnNotes]
	
	//Manual counter
	@State private var numberOfRowsManual = UserDefaults.standard.integer(forKey: "numberOfRowsManual")
	@State private var rowsOfRowsManual = UserDefaults.standard.integer(forKey: "rowsOfRowsManual")
	
	//Automatic counter
	@AppStorage("useAutomaticCounter") var useAutomaticCounter: Bool = false
	
	@State private var totalNumberOfRowsAutomatic = UserDefaults.standard.integer(forKey: "totalNumberOfRows")
	
	//Pickers
	@State private var rowCountPicker = UserDefaults.standard.integer(forKey: "rowCountPicker") != 0 ? UserDefaults.standard.integer(forKey: "rowCountPicker") : 4
	
	@State private var countByPicker = UserDefaults.standard.integer(forKey: "countByPicker") != 0 ? UserDefaults.standard.integer(forKey: "countByPicker") : 1
	
	//Bools
	@AppStorage("showExtraButton") var showExtraButton: Bool = false
	@State private var showAlert = false
	
	var rowsOfRows: Int {
		let denominator = rowCountPicker * countByPicker
		return denominator == 0 ? 0 : totalNumberOfRowsAutomatic / denominator
	}

	var body: some View {
		ScrollView {
			VStack {
//				Text("Number of rows: \(numberOfRowsManual)")
//				Text("Total number of rows: \(totalNumberOfRowsAutomatic)")
//				Text("Rows of rows: \(rowsOfRows)")
			}
			VStack(spacing: 5) {
				TitleView(title: "KnitBuddy")
				VStack(spacing: 5) {
					CounterView(
						numberOfRows: $numberOfRowsManual,
						countByPicker: $countByPicker,
						totalRowCount: $totalNumberOfRowsAutomatic,
						rowCountPicker: $rowCountPicker,
						useAutomaticCounter: useAutomaticCounter,
						rowsOfRows: rowsOfRows
					)
					
					CounterSuppView(
						numberOfRows: $numberOfRowsManual,
						totalNumberOfRows: $totalNumberOfRowsAutomatic,
						countBy: $countByPicker
					)
				}
				
				RoundedRectangle(cornerRadius: 12)
					.frame(maxHeight: 2)
					.padding(.vertical, 10)
					.foregroundStyle(.flameOrange)
				
				VStack {
					ToggleView(incomingBool: $useAutomaticCounter, trueString: "Switch to Manual Counter", falseString: "Switch to Automatic Counter")
					
					
//					Text("Number of Sections (Rows of Rows)")
//						.foregroundStyle(.flameOrange)
//						.font(.caption)
//						.fontWeight(.semibold)
//						.frame(maxWidth: .infinity, alignment: .leading)
					
							
					if !useAutomaticCounter {
									ManualRowCounter(rowsOfRowsManual: $rowsOfRowsManual, numberOfRows: $numberOfRowsManual)
										.frame(maxHeight: 100)
										//.onAppear(perform: resetCounters)
								} else {
									AutomaticRowCounter(rowsOfRows: rowsOfRows, totalRowCount: $totalNumberOfRowsAutomatic, rowCountPicker: $rowCountPicker, numberOfRows: $numberOfRowsManual)
										.frame(maxHeight: 100)
										//.onAppear(perform: resetCounters)
								}
				}
				RoundedRectangle(cornerRadius: 12)
					.frame(maxHeight: 2)
					.padding(.vertical, 10)
					.foregroundStyle(.flameOrange)
				VStack(spacing: 0) {
					ToggleView(incomingBool: $showExtraButton, trueString: "Show Yarn Notes", falseString: "Show Extra Button")
					if showExtraButton {
						
						ExtraButtonView(
							numberOfRows: $numberOfRowsManual,
							totalNumberOfRows: $totalNumberOfRowsAutomatic,
							useAutomaticCounter: useAutomaticCounter,
							countByPicker: countByPicker,
							rowCountPicker: rowCountPicker
						)
						.padding(.vertical)
					} else {
						if let yarnDetail = yarnDetails.first {
							if !showExtraButton {
								TextEditorView(
									yarnDetails: Binding(
										get: { yarnDetail.text },
										set: { yarnDetail.text = $0 }
									))
								.transition(.opacity)
							}
						}
					}
				}
				.animation(.easeInOut(duration: 0.2), value: showExtraButton)
				}
			.padding()
		}
		//.scrollDisabled(!showTextEditor)
		.scrollIndicators(.hidden)
		.background(.peachBeige)
		.onAppear {
			if yarnDetails.isEmpty {
				createInitialYarnNotes()
			}
			
			UIApplication.shared.isIdleTimerDisabled = true
		}
		.onChange(of: numberOfRowsManual) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "numberOfRowsManual")
		}
		
		.onChange(of: rowsOfRowsManual) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "rowsOfRowsManual")
		}
		.onChange(of: totalNumberOfRowsAutomatic) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "totalNumberOfRows")
		}
		.onChange(of: countByPicker) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "countByPicker")
		}
		.onChange(of: rowCountPicker) { oldValue, newValue in
			if oldValue != newValue {
				print("The new value is set: \(newValue)")
				UserDefaults.standard.set(newValue, forKey: "rowCountPicker")
			}
		}
		.onDisappear {
			UIApplication.shared.isIdleTimerDisabled = false
		}
	}
	private func createInitialYarnNotes() {
		let initialYarnDetail = YarnNotes(text: "")
		modelContext.insert(initialYarnDetail)
		
		do {
			try modelContext.save()
			print("Initial Yarn Note created.")
		} catch {
			print("Failed to create initial Yarn Note: \(error)")
		}
	}
	private func resetCounters() {
		totalNumberOfRowsAutomatic = 0
		numberOfRowsManual = 0
		
	}
}

#Preview {
	MainView()
		.modelContainer(for: YarnNotes.self, inMemory: true)
}
