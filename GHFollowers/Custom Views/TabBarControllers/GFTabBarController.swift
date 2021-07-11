//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-05.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers = [createSearchNC(), createFavoritesNC()]
    }
	
	private func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	private func createFavoritesNC() -> UINavigationController {
		let favoritesListVC = FavoriteListVC()
		favoritesListVC.title = "Favorites"
		favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favoritesListVC)
	}
}
