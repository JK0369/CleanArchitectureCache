//
//  CityRepository.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

enum Order: String, Encodable {
    case revenue
}

enum SortOrder: String, Encodable {
    case desc
}

protocol CityRepository {
    @discardableResult

    func fetchCities(order: Order,
                     sortOrder: SortOrder,
                     completion: @escaping (Result<[City], Error>) -> Void) -> Cancellable?
}
