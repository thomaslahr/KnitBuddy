//
//  PickerView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 25/12/2024.
//

import SwiftUI

struct PickerView: View {
	
	@Binding var rowCountPicker: Int
    var body: some View {
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
			.frame(width: 60, height: 50)
		}
    }
}

#Preview {
	PickerView(rowCountPicker: .constant(1))
}
