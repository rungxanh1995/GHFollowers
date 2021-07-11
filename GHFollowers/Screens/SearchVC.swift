//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-24.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
	
	private let logoImageView = UIImageView()
	private let usernameTextField = GFTextField()
	private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
	
	private var isUsernameEntered: Bool { return !(usernameTextField.text!.isEmpty) }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubviews(logoImageView, usernameTextField, callToActionButton)

		configureLogoImageView()
		configureTextField()
		configureCallToActionButton()
		dismissKeyboardOnTap()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		usernameTextField.clearsOnBeginEditing = true
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
}


extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}


extension SearchVC {
	@objc
	private func pushFollowerListVC() {
		guard isUsernameEntered else {
			presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😅", buttonTitle: "Ok")
			return
		}
		usernameTextField.resignFirstResponder()
		let followerListVC      = FollowerListVC(username: usernameTextField.text!)
		navigationController?.pushViewController(followerListVC, animated: true)
	}
	
	private func dismissKeyboardOnTap() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tap)
	}
	
	private func configureLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.ghLogo
		
		let topConstraintConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 20 : 80
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 180),
			logoImageView.widthAnchor.constraint(equalToConstant: 180)
		])
	}
	
	private func configureTextField() {
		usernameTextField.delegate = self
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	private func configureCallToActionButton() {
		callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			callToActionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
