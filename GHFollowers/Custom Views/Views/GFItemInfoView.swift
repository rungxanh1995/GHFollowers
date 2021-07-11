//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-30.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFItemInfoView: UIView {
	
	enum ItemInfoType { case repos, gists, following, followers }

	private let symbolImageView	= UIImageView()
	private let titleLabel		= GFTitleLabel(textAlignment: .natural, fontSize: 14)
	private let countLabel		= GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		addSubviews(symbolImageView, titleLabel, countLabel)

		symbolImageView.tintColor 	= .label
		symbolImageView.contentMode = .scaleAspectFill
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
			symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			symbolImageView.heightAnchor.constraint(equalToConstant: 20),
			
			titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18),
			
			countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
			countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			countLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}
	
	func set(itemInfoType: ItemInfoType, withCount count: Int) {
		switch itemInfoType {
		case .repos:
			symbolImageView.image 	= SFSymbols.repos
			titleLabel.text 		= "Public Repos"
		case .gists:
			symbolImageView.image 	= SFSymbols.gists
			titleLabel.text 		= "Public Gists"
		case .following:
			symbolImageView.image 	= SFSymbols.following
			titleLabel.text 		= "Following"
		case .followers:
			symbolImageView.image	= SFSymbols.followers
			titleLabel.text			= "Followers"
		}
		countLabel.text 			= String(count)
	}
}
