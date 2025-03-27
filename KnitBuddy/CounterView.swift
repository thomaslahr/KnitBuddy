//
//  CounterView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI

struct CounterView: View {
	@Binding var numberOfRows: Int
	@Binding var countByPicker: Int
	@Binding var totalRowCount: Int
	@Binding var rowCountPicker: Int
	
	var useAutomaticCounter: Bool
	var rowsOfRows: Int
	
    var body: some View {
		HStack {
			VStack {
				Text("NUMBER OF ROWS:")
					.fontWeight(.bold)
					.fontDesign(.rounded)
					.foregroundStyle(.flameOrange)
				Text("\(numberOfRows)")
						.font(.system(size: 100))
						.foregroundStyle(.white)
						.frame(maxWidth: .infinity, maxHeight: 130)
						.background {
							RoundedRectangle(cornerRadius: 12)
								.fill(GradientColors.primaryAppColor)
						}
				}
			
			Button {
				numberOfRows += countByPicker
				totalRowCount += countByPicker
				
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
					.font(.system(size: 150))
					.foregroundStyle(GradientColors.primaryAppColor)
			}
			.padding(.leading, 5)
			.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: numberOfRows)
		}
    }
}

#Preview {
	CounterView(numberOfRows: .constant(2), countByPicker: .constant(1), totalRowCount: .constant(2), rowCountPicker: .constant(2), useAutomaticCounter: false, rowsOfRows: 4)
}
