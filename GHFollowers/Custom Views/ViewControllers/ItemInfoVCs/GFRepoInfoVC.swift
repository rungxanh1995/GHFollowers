//
//  GFRepoInfoVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-03.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFRepoInfoVC: GFItemInfoVC {
	
	weak var delegate: RepoInfoVCDelegate!
	
	init(user: User, delegate: RepoInfoVCDelegate) {
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
		itemInfoOne.set(itemInfoType: .repos, withCount: user.publicRepos)
		itemInfoTwo.set(itemInfoType: .gists, withCount: user.publicGists)
		actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
	}
	
	override func didTapActionButton() {
		delegate.didTapGithubProfile(for: user)
	}
}
