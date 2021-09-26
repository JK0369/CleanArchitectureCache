//
//  CityUseCase.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

protocol CityUseCase {
    @discardableResult
    func execute(requestValue: CityUseCaseRequestValue,
                 completion: @escaping (Result<[City], Error>) -> Void) -> Cancellable?
}

final class CityUseCaseImpl: CityUseCase {

    /// DIP: CityRepository에서 network가 바뀌든, CityRepository는 protocol이므로 json이 xml로 되든간에 영향을 받지 않는 코드
    private let cityRepository: CityRepository

    init(cityRepository: CityRepository) {
        self.cityRepository = cityRepository
    }

    func execute(requestValue: CityUseCaseRequestValue, completion: @escaping (Result<[City], Error>) -> Void) -> Cancellable? {

        return cityRepository.fetchCities(order: requestValue.order,
                                         sortOrder: requestValue.sortOrder) { result in
            if case .success = result {
                // TODO: cache 저장
            }

            switch result {
            case .success(let response):
                return completion(.success(response))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}

struct CityUseCaseRequestValue {
    let order: Order
    let sortOrder: SortOrder
}
