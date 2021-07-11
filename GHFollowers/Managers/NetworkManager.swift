//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-06-25.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import UIKit

class NetworkManager {
	
	static let shared 	= NetworkManager()
	internal let cache 	= NSCache<NSString, UIImage>()
	private let baseURL = "https://api.github.com/users/"
	internal let followersPerPage = 100
	
	
	private init() {}
	
	
	func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
		let endpoint = "/followers?per_page=\(followersPerPage)&page=\(page)"
		getGenericJSONData(for: username, with: endpoint, completionHandler: completed)
	}
	
	
	func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
		getGenericJSONData(for: username, with: nil, completionHandler: completed)
	}
	
	
	private func getGenericJSONData<T: Decodable>(for username: String, with endpoint: String?, completionHandler: @escaping (Result<T, GFError>) -> Void) {
		var completeEndpoint = baseURL + "\(username)"
		if let endpoint = endpoint { completeEndpoint.append(endpoint) }
		
		guard let url = URL(string: completeEndpoint) else {
			completionHandler(.failure(.invalidUsername))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if error != nil {
				completionHandler(.failure(.unableToComplete))
			}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completionHandler(.failure(.invalidResponse))
				return
			}
			guard let data = data else {
				completionHandler(.failure(.invalidData))
				return
			}
			do {
				let decoder						= JSONDecoder()
				decoder.keyDecodingStrategy		= .convertFromSnakeCase
				decoder.dateDecodingStrategy	= .iso8601
				let decodedData					= try decoder.decode(T.self, from: data)
				completionHandler(.success(decodedData))
			} catch {
				completionHandler(.failure(.invalidData))
			}
		}
		.resume()
	}
	
	
	func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
		let cacheKey = NSString(string: urlString)
		if let image = cache.object(forKey: cacheKey) {
			completed(image)
			return
		}
		
		guard let url = URL(string: urlString) else { completed(nil); return }
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard
				let self = self,
				error == nil,
				let response = response as? HTTPURLResponse, response.statusCode == 200,
				let data = data,
				let image = UIImage(data: data) else { completed(nil); return }
			self.cache.setObject(image, forKey: cacheKey)
			completed(image)
		}
		.resume()
	}
}
