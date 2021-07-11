 //
//  GFButton.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(backgroundColor: UIColor, title: String) {
		self.init(frame: .zero)
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints	= false
		layer.cornerRadius 							= 10
		titleLabel?.font							= UIFont.preferredFont(forTextStyle: .headline)
		setTitleColor(UIColor.white, for: .normal)
	}
	
	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		setTitle(title, for: .normal)
	}
}
