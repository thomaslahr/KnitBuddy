//
//  RotatedText.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 08/06/2025.
//

import SwiftUI

struct RotatedText: View {
	let title: String
	
    var body: some View {
		Text(title.uppercased())
			.foregroundStyle(.peachBeige)
			.fontDesign(.rounded)
			.font(.system(size: 10))
			.fontWeight(.bold)
			.fixedSize()
			.frame(width: 20, height: 80)
			.rotationEffect(.degrees(270))
			.padding(.leading, -15)
    }
}

#Preview {
	RotatedText(title: "Manual")
}
