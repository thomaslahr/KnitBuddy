//
//  MainView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI
import SwiftData

struct SimpleCounter: View {
	@Environment(\.modelContext) private var modelContext
	
	@StateObject private var mainViewModel = MainViewModel()
	@State private var isAddingCounter = false
	@State private var showSettings = false
	
	var body: some View {
		VStack {
			TitleView(title: "KnitBuddy", size: 28.0, colorStyle: .flameOrange)
				.frame(maxWidth: .infinity)
//				.overlay(alignment: .trailing) {
//					
//					Button {
//						isAddingCounter.toggle()
//					} label: {
//						//						VStack {
//						//							Text("Add number")
//						//							Text("of stiches")
//						//						}
//						//						.foregroundStyle(GradientColors.primaryAppColor)
//						//						.fontWeight(.bold)
//						//							.font(.system(size: 10))
//						//							.padding(7)
//						//							.background {
//						//								RoundedRectangle(cornerRadius: 12)
//						//									.stroke(GradientColors.primaryAppColor, lineWidth: 2)
//						//							}
//						//
//						//					}
//						//					.padding(.leading, 20)
//						Image(systemName: "plus.circle")
//							.font(.system(size: 40))
//							.fontWeight(.light)
//							.foregroundStyle(GradientColors.primaryAppColor)
//							.padding(.trailing, 20)
//					}
//				}
//				.overlay(alignment: .leading) {
//					Button {
//						showSettings.toggle()
//					} label: {
//						Image(systemName: "gear")
//							.font(.system(size: 40))
//							.fontWeight(.light)
//							.foregroundStyle(GradientColors.primaryAppColor)
//							.padding(.leading, 20)
//					}
//				}
			ScrollView {
				VStack(spacing: 5) {
					VStack(spacing: 5) {
//						Text("Total number of stitches: \(mainViewModel.totalNumberOfStitchesAutomatic)")
						MainCounter(
							numberOfStitches: $mainViewModel.numberOfStitchesManual,
							countByPicker: $mainViewModel.countByPicker,
							totalRowCount: $mainViewModel.totalNumberOfStitchesAutomatic,
							rowCountPicker: $mainViewModel.rowCountPicker,
							useAutomaticCounter: mainViewModel.useAutomaticCounter,
							rowsOfRows: mainViewModel.rowsOfStiches
						)
						
						CounterSupporter(
							numberOfStitches: $mainViewModel.numberOfStitchesManual,
							totalNumberOfRows: $mainViewModel.totalNumberOfStitchesAutomatic,
							countBy: $mainViewModel.countByPicker, totalNumberOfStitches: $mainViewModel.totalNumberOfStitchesAutomatic
						)
					}
					
					CustomDivider(color: .flameOrange)
					
					VStack {
						ToggleView(incomingBool: $mainViewModel.useAutomaticCounter, trueString: "Switch to Manual Row Counter", falseString: "Switch to Automatic Row Counter")
						
						
						if !mainViewModel.useAutomaticCounter {
							ManualRowCounter(rowsOfStitchesManual: $mainViewModel.rowsOfStitchesManual, numberOfRows: $mainViewModel.numberOfStitchesManual)
								.frame(maxHeight: 100)
							//.onAppear(perform: resetCounters)
						} else {
							AutomaticRowCounter(
								rowsOfStitches: mainViewModel.rowsOfStiches,
								numberOfStitches: $mainViewModel.numberOfStitchesManual, totalNumberOfStitches: $mainViewModel.totalNumberOfStitchesAutomatic, rowCountPicker: $mainViewModel.rowCountPicker, numberOfRows: $mainViewModel.numberOfStitchesManual)
							.frame(maxHeight: 100)
							//.onAppear(perform: resetCounters)
						}
					}
//					DividerView(color: .flameOrange)
					
//					VStack(spacing: 0) {
//						ToggleView(incomingBool: $mainViewModel.showExtraButton, trueString: "Show Yarn Notes", falseString: "Show Extra Button")
//						if mainViewModel.showExtraButton {
//							
//							ExtraButtonView(
//								numberOfRows: $mainViewModel.numberOfStitchesManual,
//								totalNumberOfRows: $mainViewModel.totalNumberOfStitchesAutomatic,
//								useAutomaticCounter: mainViewModel.useAutomaticCounter,
//								countByPicker: mainViewModel.countByPicker,
//								rowCountPicker: mainViewModel.rowCountPicker
//							)
//							.padding(.vertical)
//						} else {
//							if let yarnDetail = yarnDetails.first {
//								if !mainViewModel.showExtraButton {
//									TextEditorView(
//										yarnDetails: Binding(
//											get: { yarnDetail.text },
//											set: { yarnDetail.text = $0 }
//										),
//										viewTitle: "Notes",
//										viewHeight: 250)
//									.transition(.opacity)
//								}
//							}
//						}
//					}
//					.animation(.easeInOut(duration: 0.2), value: mainViewModel.showExtraButton)
				}
				.frame(maxHeight: .infinity)
				.padding()
			}
			//.scrollDisabled(!showTextEditor)
			.scrollIndicators(.hidden)
			.onAppear {
				if !isPreviewMode {
					UIApplication.shared.isIdleTimerDisabled = true
				}
			}
			.onDisappear {
				if !isPreviewMode {
					UIApplication.shared.isIdleTimerDisabled = false
				}
			}
			.onChange(of: mainViewModel.numberOfStitchesManual) { _, newValue in
				saveToUserDefaults(value: newValue, key: "numberOfRowsManual")
			}
			
			.onChange(of: mainViewModel.rowsOfStitchesManual) { _, newValue in
				saveToUserDefaults(value: newValue, key: "rowsOfRowsManual")
			}
			.onChange(of: mainViewModel.totalNumberOfStitchesAutomatic) { _, newValue in
				saveToUserDefaults(value: newValue, key: "totalNumberOfRows")
			}
			.onChange(of: mainViewModel.countByPicker) { _, newValue in
				saveToUserDefaults(value: newValue, key: "countByPicker")
			}
			.onChange(of: mainViewModel.rowCountPicker) { oldValue, newValue in
				if oldValue != newValue {
					print("The new value is set: \(newValue)")
					saveToUserDefaults(value: newValue, key: "rowCountPicker")
				}
			}
		}
		.background(.peachBeige)
//		.sheet(isPresented: $isAddingCounter) {
//			CreateCounterSheet(comesFromSimpleCounter: true, numberOfRows: mainViewModel.numberOfStitchesManual)
//				.presentationDetents([.medium])
//		}
	}
	
	private var isPreviewMode: Bool {
		ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
	}
	
	private func saveToUserDefaults<T>(value: T, key: String) {
		if isPreviewMode { return }
		UserDefaults.standard.set(value, forKey: key)
		
	}
}

#Preview {
	SimpleCounter()
}
