//
//  ControlsImageView.swift
//  Pinch
//
//  Created by Yasser Ghannam on 29/09/2023.
//

import SwiftUI

struct ControlsImageButtonView: View {
	
	// MARK: - Properties
	let icon: String
	let functionality: String
	@Binding var imageScale: CGFloat
	@Binding var imageOffset: CGSize
	
	// MARK: - Methods
	private func resetImageState() {
		return withAnimation(.spring()) {
			imageScale = 1
			imageOffset = .zero
		}
	}
	
    var body: some View {
		Button {
			withAnimation(.spring()) {
				if functionality == .scaleUp {
					withAnimation(.spring()) {
						if imageScale < 5 {
							imageScale += 1
						} else if imageScale > 5 {
							imageScale = 5
						} 
					}
				} else if functionality == .scaleDown {
					if imageScale > 1 {
						imageScale -= 1
					} else if imageScale <= 1 {
						resetImageState()
					}
				} else if functionality == .reset {
					resetImageState()
				}
			}
		} label: {
			Image(systemName: icon)
				.font(.system(size: 36))
		}
    }
}

#Preview {
	ControlsImageButtonView(icon: "", functionality: "", imageScale: .constant(0), imageOffset: .constant(.zero))
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		.previewLayout(.sizeThatFits)
		.padding()
}
