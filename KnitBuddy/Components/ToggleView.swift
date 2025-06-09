//
//  ToggleView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 27/03/2025.
//

import SwiftUI

struct ToggleView: View {
	@Binding var incomingBool: Bool
	let trueString: String
	let falseString: String
    var body: some View {
		Toggle(isOn: $incomingBool) {
			Text(incomingBool ? trueString : falseString)
				.foregroundStyle(.black)
				.fontWeight(.semibold)
		}
		.padding(.trailing, 5)
    }
}

#Preview {
	ToggleView(incomingBool: .constant(true), trueString: "Switch to Manual Counter", falseString: "Switch to Automatic Counter")
}
