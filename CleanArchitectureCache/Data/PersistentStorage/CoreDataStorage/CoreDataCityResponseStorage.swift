//
//  CoreDataCityResponseStorage.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/25.
//

import Foundation
import CoreData

final class CoreDataCityResponseStorage {
    private let maxStorageLimit: Int
    private let coreDataStorage: CoreDataStorage

    init(maxStorageLimit: Int, coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.maxStorageLimit = maxStorageLimit
        self.coreDataStorage = coreDataStorage
    }
}

extension CoreDataCityResponseStorage: CityResponseStorage {
    func fetchResponse(maxCount: Int, completion: @escaping (Result<[City], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = CityEntity.fetchRequest()
                request.fetchLimit = maxCount
                let result = try context.fetch(request).map { $0.toDomain() }
                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
}
