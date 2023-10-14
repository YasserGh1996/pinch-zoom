//
//  DrawerView.swift
//  Pinch
//
//  Created by Yasser Ghannam on 14/10/2023.
//

import SwiftUI

struct DrawerView: View {
	@Binding var isAnimating: Bool
	@Binding var isDrawerOpen: Bool
	
	var pages: [PageModel] = pagesData
	@Binding var pageIndex: Int
	
    var body: some View {
		HStack {
			// MARK: - Drawer Handle
			Image(systemName: isDrawerOpen ? .image.chevroncompactright : .image.chevronCompactLeft)
				.resizable()
				.scaledToFit()
				.frame(height: 40)
				.padding(8)
				.foregroundColor(.secondary)
				.onTapGesture(perform: {
					withAnimation(.easeOut) {
						isDrawerOpen.toggle()
					}
				})
			
			// MARK: - Thumbnails
			ForEach(pages) { item in
				Image(item.thumbnailName)
					.resizable()
					.scaledToFit()
					.frame(width: 80)
					.cornerRadius(8)
					.shadow(radius: 4)
					.opacity(isDrawerOpen ? 1 : 0)
					.animation(.easeOut(duration: 0.5), value: isDrawerOpen)
					.onTapGesture(perform: {
						isAnimating = true
						pageIndex = item.id - 1
					})
			}
			
			Spacer()
		}
		// MARK: - Drawer
		.padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
		.background(.ultraThinMaterial)
		.cornerRadius(12)
		.opacity(isAnimating ? 1 : 0)
		.frame(width: 260)
		.padding(.top, UIScreen.main.bounds.height / 12)
		.offset(x: isDrawerOpen ? 20 : 215)
	}
}

#Preview {
	DrawerView(isAnimating: .constant(true), isDrawerOpen: .constant(false), pageIndex: .constant(0))
}
