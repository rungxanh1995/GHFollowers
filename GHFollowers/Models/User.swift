//
//  User.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-25.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import Foundation

struct User: Codable {
	
	let login		: String
	let avatarUrl	: String
	var name		: String?
	var location	: String?
	var bio			: String?
	let publicRepos	: Int
	let publicGists	: Int
	let htmlUrl		: String
	let following	: Int
	let followers	: Int
	let createdAt	: Date
}
