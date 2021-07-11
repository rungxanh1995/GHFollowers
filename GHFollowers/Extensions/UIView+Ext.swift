//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-10.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

extension UIView {
	
	func addSubviews(_ view: UIView...) { view.forEach(addSubview) }
	
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}
