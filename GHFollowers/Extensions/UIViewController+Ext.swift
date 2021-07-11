//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit
import SafariServices

internal var containerView: UIView!

extension UIViewController {

	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle 	= .overFullScreen
			alertVC.modalTransitionStyle 	= .crossDissolve
			self.present(alertVC, animated: true)
		}
	}
	
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor	= .systemGreen
		safariVC.modalPresentationStyle		= .automatic
		present(safariVC, animated: true)
	}
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView = GFEmptyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
}
