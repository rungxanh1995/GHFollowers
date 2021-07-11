//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		
		layer.cornerRadius			= 10
		layer.borderWidth			= 2
		layer.borderColor			= UIColor.systemGray4.cgColor
		backgroundColor				= .tertiarySystemBackground

		placeholder					= "Type a username"
		textColor					= .label
		tintColor					= .label
		textAlignment				= .center
		font						= UIFont.preferredFont(forTextStyle: .title2)

		adjustsFontSizeToFitWidth	= true
		minimumFontSize				= 12
		autocorrectionType			= .no
		returnKeyType				= .go
		clearButtonMode				= .whileEditing
		autocapitalizationType		= .none
	}
}
