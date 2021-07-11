//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController, Loadable {
	
	internal var containerView: UIView!
	
	private enum Section { case main }

	private var username: String!
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username	= username
		title			= username
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private var page = 1
	private var followers: [Follower] = []
	private var filteredFollowers: [Follower] = []
	private var hasMoreFollowers = true
	private var isSearching = false
	private var isLoadingMoreFollowers = false
	
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureSearchController()
		configureCollectionView()
		configureDataSource()
		getFollowers(for: username, page: page)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		NetworkManager.shared.cache.removeAllObjects()
	}
}


extension FollowerListVC {
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let favoriteButton = UIBarButtonItem(image: SFSymbols.favorite, style: .plain, target: self, action: #selector(didTapFavButton))
		navigationItem.rightBarButtonItem = favoriteButton
	}
	
	private func configureCollectionView() {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.configureThreeColumnFlowLayout(in: view)
		
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
		collectionView.delegate 			= self
		collectionView.backgroundColor 		= .systemBackground
		collectionView.keyboardDismissMode 	= .onDrag
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
		view.addSubview(collectionView)
	}
	
	private func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else { fatalError("Cannot create new cell") }
			cell.set(with: follower)
			return cell
		})
	}
	
	private func configureSearchController() {
		let searchController 						= UISearchController()
		navigationItem.searchController 			= searchController
		searchController.searchResultsUpdater 		= self
		searchController.searchBar.placeholder 		= "Search for a username"
		searchController.obscuresBackgroundDuringPresentation = false
	}
	
	private func getFollowers(for username: String, page: Int) {
		isLoadingMoreFollowers = true
		showLoadingView()
		
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()
			
			switch result {
			case .success(let followers):
				self.updateUI(with: followers)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
			}
			self.isLoadingMoreFollowers = false
		}
	}
	
	private func updateUI(with followers: [Follower]) {
		/// if next page has less than pre-set no. of followers per page
		/// it's a sign there's no more next page after that
		if followers.count < NetworkManager.shared.followersPerPage { self.hasMoreFollowers = false }
		self.followers.append(contentsOf: followers)
		
		if self.followers.isEmpty {
			let message = "This user doesn't have any followers.\nGo follow them 😊."
			DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
			return
		}
		self.updateData(on: self.followers)
	}
	
	private func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
	}
	
	@objc
	private func didTapFavButton() {
		showLoadingView()
		
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()
			
			switch result {
			case .success(let user):
				self.addToFavorites(user: user)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	private func addToFavorites(user: User) {
		let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
		PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
			guard let self = self else { return }
			guard let error = error else {
				self.presentGFAlertOnMainThread(title: "Success!",
												message: "You have successfully added this user to your Favorites 🥳",
												buttonTitle: "Yay!")
				return
			}
			self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
		}
	}
}


extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let contentOffsetY 	= scrollView.contentOffset.y
		let contentHeight 	= scrollView.contentSize.height
		let viewHeight		= scrollView.frame.size.height
		
		if (contentOffsetY > contentHeight - viewHeight) {
			guard hasMoreFollowers, !isLoadingMoreFollowers, !isSearching else { return }
			page += 1
			getFollowers(for: username, page: page)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedFollower	= isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
		let destVC				= UserInfoVC(username: selectedFollower.login)
		destVC.delegate			= self
		let navController 		= UINavigationController(rootViewController: destVC)
		present(navController, animated: true)
	}
}


extension FollowerListVC: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else {
			isSearching = false
			filteredFollowers.removeAll()
			updateData(on: followers)
			return
		}
		isSearching = true
		filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
		updateData(on: filteredFollowers)
	}
}


extension FollowerListVC: UserInfoVCDelegate {
	func didRequestFollowers(for username: String) {
		self.username			= username
		title					= username
		page					= 1
		hasMoreFollowers		= true
		isSearching				= false
		isLoadingMoreFollowers	= false
		
		followers.removeAll()
		filteredFollowers.removeAll()
		
		collectionView.scrollsToTop = true
		getFollowers(for: username, page: page)
	}
}
