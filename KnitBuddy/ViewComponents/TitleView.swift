//
//  TitleView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 27/03/2025.
//

import SwiftUI

struct TitleView<T: ShapeStyle>: View {
	let title: String
	let size: CGFloat
	let colorStyle: T
    var body: some View {
		HStack {
			Text(title)
				.font(.system(size: size))
				.fontWeight(.black)
				.fontDesign(.rounded)
				.foregroundStyle(colorStyle)
				//.padding(5)
			
		}
    }
}

#Preview {
	TitleView(title: "KnitBuddy", size: 34.0, colorStyle: .flameOrange)
}
