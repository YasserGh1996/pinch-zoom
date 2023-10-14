//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Yasser Ghannam on 29/09/2023.
//

import SwiftUI

struct InfoPanelView: View {
	var scale: CGFloat
	var offset: CGSize
	
	@State private var isInfoPanelViseble: Bool = false
	
    var body: some View {
		HStack {
			// MARK: - Hotspot
			Image(systemName: .image.doubleCircle)
				.symbolRenderingMode(.hierarchical)
				.resizable()
				.frame(width: 30, height: 30)
				.onLongPressGesture (minimumDuration: 1.5) {
					withAnimation(.easeOut) {
						isInfoPanelViseble.toggle()
					}
				}
			
			Spacer()
			
			// MARK: - Info Panel
			HStack(spacing: 2) {
				Image(systemName: .image.arrowUpLeftRight)
				Text("\(scale)")
				
				Spacer()
				
				Image(systemName: .image.arrowLeftRight)
				Text("\(offset.width)")
				
				Spacer()
				
				Image(systemName: .image.arrowUpDown)
				Text("\(offset.height)")
				
				Spacer()
			}
			.font(.footnote)
			.padding(8)
			.background(.ultraThinMaterial)
			.cornerRadius(8.0)
			.frame(maxWidth: 450)
			.opacity(isInfoPanelViseble ? 1 : 0)
			
			Spacer()
		}
    }
}

#Preview {
	InfoPanelView(scale: 1, offset: .zero)
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		.previewLayout(.sizeThatFits)
		.padding()
}
