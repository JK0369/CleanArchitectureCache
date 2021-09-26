//
//  UserDefaultsCityStorage.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/25.
//

import Foundation

final class UserDefaultsCityStorage {
    private let maxStorageLimit: Int
    private let cityStorageKey = "cityStorage"
    private var userDefaults: UserDefaults

    init(maxStorageLimit: Int, userDefaults: UserDefaults = UserDefaults.standard) {
        self.maxStorageLimit = maxStorageLimit
        self.userDefaults = userDefaults
    }

    private func fetchCities() -> [City] {
        if let citiesData = userDefaults.object(forKey: cityStorageKey) as? Data {
            if let cities = try? JSONDecoder().decode(CityListUDS.self, from: citiesData) {
                return cities.list.map { $0.toDomain() }
            }
        }
        return []
    }

    private func persist(cities: [City]) {
        let encoder = JSONEncoder()
        let cityListUDS = cities.map(CityUDS.init)
        if let encoded = try? encoder.encode(CityListUDS(list: cityListUDS)) {
            userDefaults.set(encoded, forKey: cityStorageKey)
        }
    }
}

extension UserDefaultsCityStorage: CityResponseStorage {
    func getResponse(maxCount: Int, completion: @escaping (Result<[City], Error>) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard var cities = self?.fetchCities() else { return }

            let maxStorageLimit = self?.maxStorageLimit ?? 0
            cities = cities.count < maxStorageLimit ? cities : Array(cities[0..<maxCount])
            completion(.success(cities))
        }
    }

    func save(cities: [City]) {
        persist(cities: cities)
    }
}
