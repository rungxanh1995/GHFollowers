//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-01.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
	private let stackView	= UIStackView()
	let itemInfoOne			= GFItemInfoView()
	let itemInfoTwo			= GFItemInfoView()
	let actionButton 		= GFButton()
	
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
		configureViewController()
		configureStackView()
		configureActionButton()
		layoutUI()
    }
}

extension GFItemInfoVC {
	private func configureViewController() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
	}
	
	private func configureStackView() {
		stackView.axis			= .horizontal
		stackView.distribution 	= .equalSpacing
		stackView.addArrangedSubview(itemInfoOne)
		stackView.addArrangedSubview(itemInfoTwo)
	}
	
	private func configureActionButton() {
		actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
	}
	
	@objc
	func didTapActionButton() { }
	
	private func layoutUI() {
		view.addSubviews(stackView, actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		let padding: CGFloat = 20
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}
