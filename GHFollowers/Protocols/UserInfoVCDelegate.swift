//
//  UserInfoVCDelegate.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-10.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import Foundation

protocol UserInfoVCDelegate: AnyObject {
	
	func didRequestFollowers(for username: String)
	
}
