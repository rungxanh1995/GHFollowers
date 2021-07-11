//
//  Loadable.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-10.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

protocol Loadable: AnyObject {
	var containerView: UIView! { get set }
	func showLoadingView()
	func dismissLoadingView()
}

extension Loadable where Self: UIViewController {
	
	func showLoadingView() {
		containerView = UIView(frame: view.bounds)
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		view.addSubview(containerView)
		UIView.animate(withDuration: 0.25) {
			self.containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
		])
		activityIndicator.startAnimating()
	}
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			self.containerView.removeFromSuperview()
			self.containerView = nil
		}
	}
}
