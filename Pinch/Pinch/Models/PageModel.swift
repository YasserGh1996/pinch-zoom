//
//  PageModel.swift
//  Pinch
//
//  Created by Yasser Ghannam on 14/10/2023.
//

import Foundation

struct PageModel: Identifiable {
	let id: Int
	let imageName: String
}

extension PageModel {
	var thumbnailName: String {
		return "thumb-" + imageName
	}
}
