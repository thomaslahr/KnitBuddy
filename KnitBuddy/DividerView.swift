//
//  DividerView.swift
//  KnitBuddy
//
//  Created by Thomas Lahr on 27/03/2025.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
		RoundedRectangle(cornerRadius: 12)
			.frame(maxHeight: 2)
			.padding(.vertical, 10)
			.foregroundStyle(.flameOrange)
    }
}

#Preview {
    DividerView()
}
