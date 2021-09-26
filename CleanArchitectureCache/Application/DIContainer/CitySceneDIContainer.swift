//
//  CitySceneDIContainer.swift
//  SOLID
//
//  Created by 김종권 on 2021/09/23.
//

import Foundation
import UIKit

final class CitySceneDIContainer {

    struct Dependencies {
        let cityDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies
    private let cityResponseCache = UserDefaultsCityStorage(maxStorageLimit: 10)

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeCityCoordinator(navigationController: UINavigationController) -> CitySceneCoordinator {
        return CitySceneCoordinator(navigationController: navigationController, dependencies: self)
    }

    // Private

    private func makeCityRepository() -> CityRepository {
        return CityRepositoryImpl(dataTransferService: dependencies.cityDataTransferService, cache: cityResponseCache)
    }

    private func makeCityUseCase() -> CityUseCase {
        return CityUseCaseImpl(cityRepository: makeCityRepository())
    }

    private func makeCityViewModel() -> CityViewModel {
        return CityViewModelImpl(cityUseCase: makeCityUseCase())
    }

}

extension CitySceneDIContainer: CitySceneCoordinatorDepoendencies {
    func makeCityViewController() -> UIViewController {
        return CityViewController.create(with: makeCityViewModel())
    }
}
