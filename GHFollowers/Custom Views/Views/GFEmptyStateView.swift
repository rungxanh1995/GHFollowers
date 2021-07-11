//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-26.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
	
	let messageLabel 	= GFTitleLabel(textAlignment: .center, fontSize: 28)
	let logoImageView 	= UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(message: String) {
		self.init(frame: .zero)
		messageLabel.text = message
	}
	
	private func configure() {
		backgroundColor = .systemBackground
		addSubviews(messageLabel, logoImageView)
		configureMessageLabel()
		configureLogoImageView()
	}
	
	private func configureMessageLabel() {
		messageLabel.numberOfLines	= 3
		messageLabel.textColor		= .secondaryLabel
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		
		let centerYConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? -80 : -130
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerYConstant),
			messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint (equalTo: self.trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200)
		])
	}
	
	private func configureLogoImageView() {
		logoImageView.image = Images.emptyStateLogo
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		let bottomConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 80 : 40
		NSLayoutConstraint.activate([
			logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
			logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomConstant)
		])
	}
}
