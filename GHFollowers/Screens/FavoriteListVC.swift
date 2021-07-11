//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController {
	
	private let tableView	= UITableView()
	private var favorites	= [Follower]()

    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureTableView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavorites()
	}
	
	private func configureViewController() {
		view.backgroundColor	= .systemBackground
		title					= "Favorites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func configureTableView() {
		view.addSubview(tableView)
		tableView.frame			= view.bounds
		tableView.rowHeight		= 80
		tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.delegate		= self
		tableView.dataSource	= self
	}
}

extension FavoriteListVC {
	private func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let favorites):
				self.updateUI(with: favorites)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	private func updateUI(with favorites: [Follower]) {
		if favorites.isEmpty {
			DispatchQueue.main.async {
				self.showEmptyStateView(with: "No Favorites.\nAdd from the follower screen 😊.", in: self.view)
			}
		} else {
			self.favorites = favorites.sorted { $0.login.localizedLowercase < $1.login.localizedLowercase }
			DispatchQueue.main.async {
				self.view.bringSubviewToFront(self.tableView)
				self.tableView.reloadData()
			}
		}
	}
}


extension FavoriteListVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
		let favorite = favorites[indexPath.row]
		cell.set(with: favorite)
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favorites.count
	}
}

extension FavoriteListVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite			= favorites[indexPath.row]
		let followerListVC      = FollowerListVC(username: favorite.login)
		navigationController?.pushViewController(followerListVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }

		PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
			guard let self = self else { return }
			guard error == nil else {
				self.presentGFAlertOnMainThread(title: "Unable to remove", message: error!.rawValue, buttonTitle: "Ok")
				return
			}
			DispatchQueue.main.async {
				self.favorites.remove(at: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .left)
			}
		}
	}
}
