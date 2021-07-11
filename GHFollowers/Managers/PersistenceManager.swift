//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Joe Pham on 2021-07-05.
//  Copyright © 2021 Joe Pham. All rights reserved.
//

import Foundation

enum PersistenceActionType { case add, remove }


enum PersistenceManager {
	
	static let defaults = UserDefaults.standard
	
	enum Keys { static let favorites = "favorites" }
	
	static func save(favorites: [Follower]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encoded = try encoder.encode(favorites)
			defaults.set(encoded, forKey: Keys.favorites)
			return nil
		} catch {
			return .unabletoFavorite
		}
	}
	
	static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
		guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
			completed(.success([]))
			return
		}
		do {
			let decoder = JSONDecoder()
			let retrieved = try decoder.decode([Follower].self, from: favoritesData)
			completed(.success(retrieved))
		} catch {
			completed(.failure(.unabletoFavorite))
		}
	}
	
	static func updateWith(favorite: Follower,
						   actionType: PersistenceActionType,
						   completed: @escaping (GFError?) -> Void) {
		retrieveFavorites { result in
			switch result {
			case .success(var favorites):
				switch actionType {
				case .add:
					guard !(favorites.contains(favorite)) else {
						completed(.duplicatedFavorite)
						return
					}
					favorites.append(favorite)
				case .remove:
					favorites.removeAll { $0 == favorite }
				}
				completed(save(favorites: favorites))
			case .failure(let error):
				completed(error)
			}
		}
	}
}
