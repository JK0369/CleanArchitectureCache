//
//  AppCoordinator.swift
//  CleanArchitectureCache
//
//  Created by 김종권 on 2021/09/26.
//

import UIKit

final class AppCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let citySceneDIContainer = appDIContainer.makeCitySceneDIContainer()
        let flow = citySceneDIContainer.makeCityCoordinator(navigationController: navigationController)

        flow.start()
    }
}
