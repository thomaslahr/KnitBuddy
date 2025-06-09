//
//  AutomaticRowCounter.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI

struct AutomaticRowCounter: View {
	//var testNumber = 999
	var rowsOfStitches: Int
	
	@Binding var numberOfStitches: Int
	@Binding var totalNumberOfStitches: Int
	@Binding var rowCountPicker: Int
	@Binding var numberOfRows: Int
	
	@State private var isTripleDigit = false
	@State private var resetCounter = false
	
	var body: some View {
		//	Text("\(numberOfStitches)")
			HStack {
				HStack {
					RotatedText(title: "Automatic")
					
					Button {
						resetCounter.toggle()
					} label: {
						Image(systemName: "arrow.counterclockwise")
					}
					.font(.system(size: 40))
					.fontWeight(.bold)
					.foregroundStyle(.peachBeige)
					
					HStack(spacing: 0) {
						Text("COUNT UP FOR EVERY")
							.font(.caption)
						ZStack {
							RoundedRectangle(cornerRadius: 8)
								.frame(width: 50, height: 40)
							Picker("Count By:", selection: $rowCountPicker) {
								ForEach(1...50, id: \.self) { number in
									Text("\(number)").tag(number)
										.foregroundStyle(.black)
								}
							}
							.pickerStyle(.wheel)
							.frame(width: 60, height: 100)
							.mask {
								RoundedRectangle(cornerRadius: 8)
									.frame(width: 50, height: 40)
							}
						}
						Text("STITCH")
							.font(.caption)
					}
					.frame(maxWidth: 200)
					.fontWeight(.semibold)
					
					HStack {
						Text("\((rowsOfStitches))")
							.font(.system(size: isTripleDigit ? 40 : 55))
							.fontWeight(.semibold)
							.foregroundStyle(.white)
					}
					.onAppear(perform: changeTextSize)
					.frame(width: 80, alignment: .trailing)
					
				}
				.frame(maxWidth: .infinity)
				.padding(.horizontal, 20)
				.foregroundStyle(.peachBeige)
				.background {
					RoundedRectangle(cornerRadius: 8)
					//.fill((Color(.systemGray6)))
						.fill(GradientColors.primaryAppColor)
					
				}
				.frame(height: 100)
				.alert("Reset number of stitches", isPresented: $resetCounter) {
					Button("Cancel", role: .cancel, action: { })
					Button("Reset", role: .destructive) {
						totalNumberOfStitches = 0
						numberOfStitches = 0
						
					}
				} message: {
					Text("This will reset number of stitches and rows.")
				}
				
				.onChange(of: rowCountPicker) {
					totalNumberOfStitches = 0
					//totalRowCount -= numberOfRows
					numberOfRows = 0
					
				}
			}

	}
	
	private func changeTextSize() {
		if rowsOfStitches > 99 {
			isTripleDigit = true
		} else {
			isTripleDigit = false
		}
	}
}

#Preview {
	AutomaticRowCounter(rowsOfStitches: 5, numberOfStitches: .constant(10), totalNumberOfStitches: .constant(12), rowCountPicker: .constant(4), numberOfRows: .constant(5))
}
