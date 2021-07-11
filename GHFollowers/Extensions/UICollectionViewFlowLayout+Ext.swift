//
//  UICollectionViewFlowLayout+Ext.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-26.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
	
	func configureThreeColumnFlowLayout(in view: UIView) {
		let width 				= view.bounds.size.width
		let padding				= CGFloat(12)
		let minItemSpacing		= CGFloat(10)
		let availableWidth 		= width - (padding * 2) - (minItemSpacing * 2)
		let itemWidth			= availableWidth / 3
	
		itemSize		= CGSize(width: itemWidth, height: itemWidth + 40)
		sectionInset	= UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
	}
}
