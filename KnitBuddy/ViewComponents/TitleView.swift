//
//  TitleView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 27/03/2025.
//

import SwiftUI

struct TitleView: View {
	let title: String
    var body: some View {
		Text(title)
			.font(.largeTitle)
			.fontWeight(.black)
			.fontDesign(.rounded)
			.foregroundStyle(.flameOrange)
			.padding(5)
			.frame(maxWidth: .infinity)
    }
}

#Preview {
	TitleView(title: "KnitBuddy")
}
