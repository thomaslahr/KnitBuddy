//
//  ManualRowCounter.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI

struct ManualRowCounter: View {
	@Binding var rowsOfStitchesManual: Int
	@Binding var numberOfRows: Int
	
	var body: some View {
		//SmallTitleView(title: "Rows of Stitches", size: 15)
		HStack {
			HStack {
				RotatedText(title: "Manual")
				
				
				//Reset and minus button
				HStack {
					Button {
						rowsOfStitchesManual = 0
					} label: {
						Image(systemName: "arrow.counterclockwise")
					}
					
					Button {
						if rowsOfStitchesManual > 0 {
							rowsOfStitchesManual -= 1
						}
					} label: {
						Image(systemName: "minus.circle")
					}
				}
				.font(.system(size: 40))
				.fontWeight(.bold)
				
				Spacer()
				
				Text("\((rowsOfStitchesManual))")
					.font(rowsOfStitchesManual > 99 ? .system(size: 40) : .system(size: 55))
					.frame(width: 80)
					.fontWeight(.semibold)
					.foregroundStyle(.white)
					.border(.black, width: 2)
				
				
				
			}
			.frame(maxWidth: .infinity, maxHeight: 100)
			.padding(.horizontal, 20)
			.foregroundStyle(.peachBeige)
			.background {
				RoundedRectangle(cornerRadius: 8)
				//	.fill((Color(.systemGray6)))
					.fill(.flameOrange)
			}
			HStack {
				Button {
					if rowsOfStitchesManual < 999 {
						rowsOfStitchesManual += 1
						numberOfRows = 0
					}
				} label: {
					Image(systemName: "plus.circle")
						.font(.system(size: 90))
						.fontWeight(.semibold)
					//.foregroundStyle(GradientColors.primaryAppColor)
						.foregroundStyle(.flameOrange)
				}
			}
		}
	}
}

#Preview {
	
	ManualRowCounter(rowsOfStitchesManual: .constant(1), numberOfRows: .constant(1))
}
