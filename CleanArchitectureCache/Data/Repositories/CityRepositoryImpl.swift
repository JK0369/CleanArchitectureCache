//
//  CityRepositoryImpl.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

final class CityRepositoryImpl {
    private let dataTransferService: DataTransferService
    private let cache: CityResponseStorage

    init(dataTransferService: DataTransferService, cache: CityResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension CityRepositoryImpl: CityRepository {
    func fetchCities(order: Order,
                     sortOrder: SortOrder,
                     cached: @escaping (([City]) -> Void),
                     completion: @escaping (Result<[City], Error>) -> Void) -> Cancellable? {

        let endpoint = APIEndpoints.getCities(with: CityRequestDTO(order: order, sortOrder: sortOrder))
        let task = RepositoryTask()

        cache.getResponse(maxCount: 10) { result in
            if case let .success(response) = result {
                cached(response)
            }

            /// ViewModel에서 네트워크 호출 cancel요청을 받은 경우 (ex - 사용자가 검색 중 취소 버튼 탭)
            guard !task.isCancelled else { return}

            task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
                switch result {
                case .success(let response):
                    self.cache.save(cities: response.toDomain())
                    completion(.success(response.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })

        }
        return task
    }
}
