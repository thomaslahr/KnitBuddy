//
//  CounterSuppView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 21/12/2024.
//

import SwiftUI

struct CounterSuppView: View {
	@Binding var numberOfRows: Int
	@Binding var totalNumberOfRows: Int
	@Binding var countBy: Int
	
	var body: some View {
		HStack {
			HStack {
				Button {
					numberOfRows = 0
				} label: {
					Image(systemName: "arrow.counterclockwise")
				}
				.padding(.horizontal, 12)
				
				Button {
					if numberOfRows > 0 {
						numberOfRows -= 1
						totalNumberOfRows -= 1
					}
				} label: {
					Image(systemName: "minus.circle")
				}
				.padding(.horizontal, 12)
			}
			.frame(maxWidth: .infinity, maxHeight: 70)
			.foregroundStyle(.peachBeige)
			.font(.system(size: 40))
			.fontWeight(.bold)
			.background {
				RoundedRectangle(cornerRadius: 8)
				//.fill((Color(.systemGray6)))
					.fill(.flameOrange)
			}
			Spacer()
			
			HStack(spacing: 0) {
				Text("COUNT BY:")
					.font(.caption)
					.fontWeight(.semibold)
					.foregroundStyle(.peachBeige)
				ZStack {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(.peachBeige)
						.frame(maxWidth: 50, maxHeight: 40)
					Picker("Count By:", selection: $countBy) {
						ForEach(1...50, id: \.self) { number in
							Text("\(number)").tag(number)
								.foregroundStyle(.black)
							
						}
						.fontWeight(.semibold)
					}
					.onChange(of: countBy) {
						resetCounters()
					}
//					.frame(width: 60, height: 100)
//					.mask {
//						RoundedRectangle(cornerRadius: 8)
//							.frame(width: 50, height: 60)
//					}
				}
				.pickerStyle(.wheel)
				.frame(maxWidth: 60, maxHeight: 70)
			}
			.frame(maxWidth: .infinity)
			.background {
				RoundedRectangle(cornerRadius: 8)
				//.fill((Color(.systemGray6)))
					.fill(.flameOrange)
			}
			
		}
		.frame(maxWidth: .infinity)
//		.background {
//			RoundedRectangle(cornerRadius: 8)
//			//.fill((Color(.systemGray6)))
//				.fill(.flameOrange)
//		}
		.onChange(of: countBy) {
			numberOfRows = 0
		}
	}
	private func resetCounters() {
		totalNumberOfRows = 0
		numberOfRows = 0
	}
}

#Preview {
	CounterSuppView(numberOfRows: .constant(2), totalNumberOfRows: .constant(2), countBy: .constant(1))
}
