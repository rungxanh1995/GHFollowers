//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
	}
	
	private func configure() {
		textColor 							= .secondaryLabel
		font								= UIFont.preferredFont(forTextStyle: .body)
		adjustsFontSizeToFitWidth 			= true
		adjustsFontForContentSizeCategory 	= true // dynamic type support
		minimumScaleFactor 					= 0.75
		lineBreakMode 						= .byWordWrapping
		translatesAutoresizingMaskIntoConstraints = false
	}
}
