//
//  AppDIContainer.swift
//  CleanArchitectureCache
//
//  Created by 김종권 on 2021/09/26.
//

import Foundation

final class AppDIContainer {

    // Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: "https://projects.propublica.org/")!)

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    // DIContainers of scenes
    func makeCitySceneDIContainer() -> CitySceneDIContainer {
        let dependencies = CitySceneDIContainer.Dependencies(cityDataTransferService: apiDataTransferService)
        return CitySceneDIContainer(dependencies: dependencies)
    }
}
