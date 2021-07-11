//
//  GFError.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-25.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import Foundation

enum GFError: String, Error {
	
	case invalidUsername 	= "This username created an invalid request. Please try again."
	case unableToComplete 	= "Unable to complete your request. Please check your internet connection."
	case invalidResponse 	= "Invalid response from the server. Please try again."
	case invalidData 		= "The data received from the server was invalid. Pleaser try again."
	case unabletoFavorite	= "Unable to favorite this user. Please try again."
	case duplicatedFavorite	= "This user is already in your favorites."
}
