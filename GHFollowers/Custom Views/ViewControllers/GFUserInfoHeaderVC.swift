//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-27.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
	
	private let avatarImageView 	= GFAvatarImageView(frame: .zero)
	private let usernameLabel		= GFTitleLabel(textAlignment: .natural, fontSize: 34)
	private let nameLabel			= GFSecondaryTitleLabel(fontSize: 18)
	private var locationImageView	= UIImageView()
	private var locationLabel		= GFSecondaryTitleLabel(fontSize: 18)
	private let bioLabel			= GFBodyLabel(textAlignment: .natural)
	
	var user: User!
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
		
		configureUIElements()
		layoutUI()
    }
}


extension GFUserInfoHeaderVC {
	private func configureUIElements() {
		avatarImageView.downloadImage(fromURL: user.avatarUrl)
		usernameLabel.text 			= user.login
		nameLabel.text				= user.name
		locationImageView.image		= SFSymbols.location
		locationImageView.tintColor	= .secondaryLabel
		locationLabel.text			= user.location ?? "No Location"
		bioLabel.text				= user.bio ?? "No Bio Available"
		bioLabel.numberOfLines		= 0
	}
	
	private func layoutUI() {
		let padding: CGFloat			= 20
		let textImagePadding: CGFloat	= 12
		locationImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			avatarImageView.widthAnchor.constraint(equalToConstant: 90),
			avatarImageView.heightAnchor.constraint(equalToConstant: 90),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			usernameLabel.heightAnchor.constraint(equalToConstant: 38),
			
			nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
			nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			
			locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
			locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			locationImageView.widthAnchor.constraint(equalToConstant: 20),
			locationImageView.heightAnchor.constraint(equalToConstant: 20),
			
			locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 20),
			
			bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
			bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
			bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bioLabel.heightAnchor.constraint(equalToConstant: 90)
		])
	}
}
