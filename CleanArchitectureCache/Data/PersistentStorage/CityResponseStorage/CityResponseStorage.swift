//
//  CityResponseStorage.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/25.
//

import Foundation

protocol CityResponseStorage {
    func getResponse(maxCount: Int, completion: @escaping (Result<[City], Error>) -> Void)
    func save(cities: [City])
}

