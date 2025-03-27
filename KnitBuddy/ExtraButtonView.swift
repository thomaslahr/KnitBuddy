//
//  ExtraButtonView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 26/12/2024.
//

import SwiftUI

struct ExtraButtonView: View {
	
	@Binding var numberOfRows: Int
	@Binding var totalNumberOfRows: Int
	
	var useAutomaticCounter: Bool
	let countByPicker: Int
	let rowCountPicker: Int
	
    var body: some View {
		HStack(spacing: 25) {
			VStack(spacing: 0) {
				Button {
					numberOfRows = 0
				} label: {
					Image(systemName: "arrow.counterclockwise")
						.font(.system(size: 70))
						.fontWeight(.semibold)
				}
				.padding(3)
			}
			.frame(maxWidth: 140, maxHeight: 140)
			.foregroundStyle(.peachBeige)
			.background {
				RoundedRectangle(cornerRadius: 8)
					.fill(.flameOrange)
			}
			VStack {
				Text("NUMBER OF ROWS:")
					.font(.caption)
					.fontWeight(.bold)
					.fontDesign(.rounded)
					.foregroundStyle(.flameOrange)
				Button {
					numberOfRows += countByPicker
					totalNumberOfRows += countByPicker
					
					if useAutomaticCounter {
						//Hvis antall rader og row count er det samme
						if ((numberOfRows - countByPicker) == rowCountPicker) && ((numberOfRows % 2) != 0) {
							numberOfRows = countByPicker
							print("if #1")
						} else if (numberOfRows - countByPicker) == (rowCountPicker * countByPicker) {
							numberOfRows = countByPicker
							print("if #2")
						} else {
							print("else")
						}
					}
				} label: {
					Image(systemName: "plus.circle")
						.font(.system(size: 120))
						.foregroundStyle(GradientColors.primaryAppColor)
				}
				.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: numberOfRows)
			}
		}
    }
}

#Preview {
	ExtraButtonView(numberOfRows: .constant(2), totalNumberOfRows: .constant(8), useAutomaticCounter: true, countByPicker: 1, rowCountPicker: 8)
}
