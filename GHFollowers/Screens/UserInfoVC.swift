//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-27.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
	
	private var username: String!
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username = username
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	weak var delegate: UserInfoVCDelegate!
	
	private let scrollView	= UIScrollView()
	private let contentView	= UIView()
	
	private let headerView 	= UIView()
	private let itemViewOne = UIView()
	private let itemViewTwo = UIView()
	private let dateLabel	= GFBodyLabel(textAlignment: .center)
	private var itemViews 	= [UIView]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureScrollView()
		layoutUI()
		getUserInfo()
    }
}


extension UserInfoVC {
	
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	private func configureScrollView() {
		view.addSubview(scrollView)
		scrollView.pinToEdges(of: view)
		
		scrollView.addSubview(contentView)
		contentView.pinToEdges(of: scrollView)
		NSLayoutConstraint.activate([
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 620)
		])
	}
	
	private func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
	
	private func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let user):
				DispatchQueue.main.async { self.configureUIElements(with: user) }
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong",
												message: error.rawValue,
												buttonTitle: "Ok")
			}
		}
	}
	
	private func configureUIElements(with user: User) {
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.add(childVC: GFRepoInfoVC(user: user, delegate: self), to: self.itemViewOne)
		self.add(childVC: GFFollowersInfoVC(user: user, delegate: self), to: self.itemViewTwo)
		self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
	}
	
	@objc
	private func dismissVC() { dismiss(animated: true) }
	
	private func layoutUI() {
		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
		
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
		for itemView in itemViews {
			contentView.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
			])
		}
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 210),
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}


extension UserInfoVC: RepoInfoVCDelegate {
	func didTapGithubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid", buttonTitle: "Ok")
			return
		}
		presentSafariVC(with: url)
	}
}

extension UserInfoVC: FollowersInfoVCDelegate {
	func didTapGetFollowers(for user: User) {
		dismissVC()
		delegate.didRequestFollowers(for: user.login)
	}
}
