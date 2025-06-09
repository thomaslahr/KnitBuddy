//
//  CustomDivider.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 27/03/2025.
//

import SwiftUI

struct CustomDivider: View {
	
	let color: Color
	
    var body: some View {
		RoundedRectangle(cornerRadius: 12)
			.frame(maxHeight: 2)
			.padding(.vertical, 10)
			.foregroundStyle(color)
    }
}

#Preview {
	CustomDivider(color: .flameOrange)
}
