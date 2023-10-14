	//
	//  ContentView.swift
	//  Pinch
	//
	//  Created by Yasser Ghannam on 08/06/2023.
	//

	import SwiftUI

	struct ContentView: View {
		
		// MARK: - Properties
		@State private var isAnimating: Bool = false
		@State private var imageScale: CGFloat = 1
		@State private var imageOffset: CGSize = .zero
		@State private var isDrawerOpen: Bool = false
		
		let pages: [PageModel] = pagesData
		@State private var pageIndex: Int = 0
		
		// MARK: - Methods
		private func resetImageState() {
			return withAnimation(.spring()) {
				imageScale = 1
				imageOffset = .zero
			}
		}
		
		var body: some View {
			NavigationView {
				ZStack {
					Color.clear
					
					// MARK: - Page Image
					Image(pages[pageIndex].imageName)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.cornerRadius(10)
						.padding()
						.shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
						.opacity(isAnimating ? 1 : 0)
						.animation(.linear(duration: 1), value: isAnimating)
						.offset(x: imageOffset.width, y: imageOffset.height)
					
						.scaleEffect(imageScale)
					
					// MARK: - 1 Tap Gesture
						.onTapGesture(count: 2) {
							if imageScale == 1 {
								withAnimation(.spring()) {
									imageScale = 5
								}
							} else {
								resetImageState()
							}
						}
					
					// MARK: - 2 Drag Gesture
						.gesture( DragGesture()
							.onChanged({ value in
								withAnimation(.linear(duration: 1)) {
									imageOffset = value.translation
								}
							})
								.onEnded({ _ in
									if imageScale <= 1 {
										resetImageState()
									}
								})
						)
					// MARK: - Magnnification Gesture
						.gesture( MagnificationGesture()
							.onChanged { value in
								if imageScale >= 1 && imageScale <= 5 {
									imageScale = value
								} else if imageScale > 5 {
									imageScale = 5
								}
								
							}
							.onEnded({ value in
								if imageScale >= 5 {
									imageScale = 5
								} else if imageScale < 1 {
									resetImageState()
								}
							})
						)
					
				} //: ZSTACK
				.navigationTitle(String.pinchZoom)
				.navigationBarTitleDisplayMode(.inline)
				.onAppear() {
					withAnimation {
						isAnimating = true
					}
				}
				// MARK: - Info Panel
				.overlay(
					InfoPanelView.init(scale: imageScale, offset: imageOffset)
						.padding(.horizontal)
						.padding(.top, 30)
					, alignment: .top
				)
				// MARK: - Controls
				.overlay(
					Group {
						HStack {
							//: Scale Up
							ControlsImageButtonView(icon: .image.plusMagnifying, functionality: .scaleUp, imageScale: $imageScale, imageOffset: $imageOffset)
							
							//: Scale Down
							ControlsImageButtonView(icon: .image.minusMagnifying, functionality: .scaleDown, imageScale: $imageScale, imageOffset: $imageOffset)
							
							//: Reset
							ControlsImageButtonView(icon: .image.arrowUpLeftRightDownGlass, functionality: .reset, imageScale: $imageScale, imageOffset: $imageOffset)
							
						} //: Contols
						.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
						.background(.ultraThinMaterial)
						.cornerRadius(12)
						.opacity(isAnimating ? 1 : 0)
					}
						.padding(.bottom, 30)
					, 	alignment: .bottom
				)
				
				// MARK: - Drawer View
				.overlay (
					DrawerView(isAnimating: $isAnimating, isDrawerOpen: $isDrawerOpen, pageIndex: $pageIndex)
					, 	alignment: .topTrailing
				)
				
			} //: NAVIGATION
			.navigationViewStyle(.stack)
		}
	}

	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
		}
	}
