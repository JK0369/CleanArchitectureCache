//
//  CityRepositoryImpl.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation

final class CityRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension CityRepositoryImpl: CityRepository {
    func fetchCities(order: Order, sortOrder: SortOrder, completion: @escaping (Result<[City], Error>) -> Void) -> Cancellable? {
        let endpoint = APIEndpoints.getCities(with: CityRequestDTO(order: order, sortOrder: sortOrder))
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in

            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })

        return task
    }
}
