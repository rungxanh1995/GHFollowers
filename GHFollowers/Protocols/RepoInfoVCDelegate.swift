//
//  RepoInfoVCDelegate.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-10.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import Foundation

protocol RepoInfoVCDelegate: AnyObject {
	
	func didTapGithubProfile(for user: User)
	
}
