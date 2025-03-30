//
//  SmallTitleView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 29/03/2025.
//

import SwiftUI

struct SmallTitleView: View {
	let title: String
	let size: CGFloat
    var body: some View {
		Text(title.uppercased())
			.font(.system(size: size))
			.fontWeight(.bold)
			.fontDesign(.rounded)
			.foregroundStyle(.flameOrange)
    }
}

#Preview {
	SmallTitleView(title: "Number of Stitches", size: 15)
}
