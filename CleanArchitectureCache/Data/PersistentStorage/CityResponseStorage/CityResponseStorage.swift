//
//  CityResponseStorage.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/25.
//

import Foundation

protocol CityResponseStorage {
    func fetchResponse(maxCount: Int, completion: @escaping (Result<[City], Error>) -> Void)
}
