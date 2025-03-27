//
//  ManualRowCounter.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI

struct ManualRowCounter: View {
	@Binding var rowsOfRowsManual: Int
	@Binding var numberOfRows: Int
	
	var body: some View {
		HStack {
			HStack {
				Text("MANUAL")
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
						rowsOfRowsManual = 0
					} label: {
						Image(systemName: "arrow.counterclockwise")
					}
					
					Button {
						if rowsOfRowsManual > 0 {
							rowsOfRowsManual -= 1
						}
					} label: {
						Image(systemName: "minus.circle")
					}
					.padding(.horizontal, 20)
				}
				.font(.system(size: 40))
				.fontWeight(.bold)
				
				Spacer()
				
				Text("\((rowsOfRowsManual))")
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
					.fill(.flameOrange)
			}
			HStack {
				Button {
					rowsOfRowsManual += 1
					numberOfRows = 0
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
	
	ManualRowCounter(rowsOfRowsManual: .constant(1), numberOfRows: .constant(1))
}
