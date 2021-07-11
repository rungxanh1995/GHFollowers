//
//  GFFollowersInfoVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-03.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFFollowersInfoVC: GFItemInfoVC {
	
	weak var delegate: FollowersInfoVCDelegate!
	
	init(user: User, delegate: FollowersInfoVCDelegate) {
		super.init(user: user)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	private func configureItems() {
		itemInfoOne.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoTwo.set(itemInfoType: .following, withCount: user.following)
		actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
	
	override func didTapActionButton() {
		delegate.didTapGetFollowers(for: user)
	}
}
