//
//  MainCounter.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI

struct MainCounter: View {
	@Binding var numberOfStitches: Int
	@Binding var countByPicker: Int
	@Binding var totalRowCount: Int
	@Binding var rowCountPicker: Int
	
	var useAutomaticCounter: Bool
	var rowsOfRows: Int
	
    var body: some View {
		HStack {
			VStack {
				SmallTitleView(title: "Number of stitches", size: 15, color: .flameOrange)
				Text("\(numberOfStitches)")
						.font(.system(size: 100))
						.foregroundStyle(.white)
						.frame(maxWidth: .infinity, maxHeight: 130)
						.background {
							RoundedRectangle(cornerRadius: 12)
								.fill(GradientColors.primaryAppColor)
						}
				}
			
			Button {
				numberOfStitches += countByPicker
				totalRowCount += countByPicker
				
				if useAutomaticCounter {
					//Hvis antall rader og row count er det samme
					if ((numberOfStitches - countByPicker) == rowCountPicker) && ((numberOfStitches % 2) != 0) {
						numberOfStitches = countByPicker
						print("if #1")
					} else if (numberOfStitches - countByPicker) == (rowCountPicker * countByPicker) {
						numberOfStitches = countByPicker
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
			.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: numberOfStitches)
		}
    }
}

#Preview {
	MainCounter(numberOfStitches: .constant(2), countByPicker: .constant(1), totalRowCount: .constant(2), rowCountPicker: .constant(2), useAutomaticCounter: false, rowsOfRows: 4)
}
