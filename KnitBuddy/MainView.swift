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
	
	@StateObject private var mainViewModel = MainViewModel()

	var body: some View {
		ScrollView {
			VStack(spacing: 5) {
				TitleView(title: "KnitBuddy")
				VStack(spacing: 5) {
					CounterView(
						numberOfRows: $mainViewModel.numberOfRowsManual,
						countByPicker: $mainViewModel.countByPicker,
						totalRowCount: $mainViewModel.totalNumberOfRowsAutomatic,
						rowCountPicker: $mainViewModel.rowCountPicker,
						useAutomaticCounter: mainViewModel.useAutomaticCounter,
						rowsOfRows: mainViewModel.rowsOfRows
					)
					
					CounterSuppView(
						numberOfRows: $mainViewModel.numberOfRowsManual,
						totalNumberOfRows: $mainViewModel.totalNumberOfRowsAutomatic,
						countBy: $mainViewModel.countByPicker
					)
				}
				
				DividerView()
				
				VStack {
					ToggleView(incomingBool: $mainViewModel.useAutomaticCounter, trueString: "Switch to Manual Counter", falseString: "Switch to Automatic Counter")
					
							
					if !mainViewModel.useAutomaticCounter {
						ManualRowCounter(rowsOfRowsManual: $mainViewModel.rowsOfRowsManual, numberOfRows: $mainViewModel.numberOfRowsManual)
										.frame(maxHeight: 100)
										//.onAppear(perform: resetCounters)
								} else {
									AutomaticRowCounter(rowsOfRows: mainViewModel.rowsOfRows, totalRowCount: $mainViewModel.totalNumberOfRowsAutomatic, rowCountPicker: $mainViewModel.rowCountPicker, numberOfRows: $mainViewModel.numberOfRowsManual)
										.frame(maxHeight: 100)
										//.onAppear(perform: resetCounters)
								}
				}
				RoundedRectangle(cornerRadius: 12)
					.frame(maxHeight: 2)
					.padding(.vertical, 10)
					.foregroundStyle(.flameOrange)
				
				VStack(spacing: 0) {
					ToggleView(incomingBool: $mainViewModel.showExtraButton, trueString: "Show Yarn Notes", falseString: "Show Extra Button")
					if mainViewModel.showExtraButton {
						
						ExtraButtonView(
							numberOfRows: $mainViewModel.numberOfRowsManual,
							totalNumberOfRows: $mainViewModel.totalNumberOfRowsAutomatic,
							useAutomaticCounter: mainViewModel.useAutomaticCounter,
							countByPicker: mainViewModel.countByPicker,
							rowCountPicker: mainViewModel.rowCountPicker
						)
						.padding(.vertical)
					} else {
						if let yarnDetail = yarnDetails.first {
							if !mainViewModel.showExtraButton {
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
				.animation(.easeInOut(duration: 0.2), value: mainViewModel.showExtraButton)
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
		.onChange(of: mainViewModel.numberOfRowsManual) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "numberOfRowsManual")
		}
		
		.onChange(of: mainViewModel.rowsOfRowsManual) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "rowsOfRowsManual")
		}
		.onChange(of: mainViewModel.totalNumberOfRowsAutomatic) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "totalNumberOfRows")
		}
		.onChange(of: mainViewModel.countByPicker) { oldValue, newValue in
			UserDefaults.standard.set(newValue, forKey: "countByPicker")
		}
		.onChange(of: mainViewModel.rowCountPicker) { oldValue, newValue in
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
}

#Preview {
	MainView()
		.modelContainer(for: YarnNotes.self, inMemory: true)
}
